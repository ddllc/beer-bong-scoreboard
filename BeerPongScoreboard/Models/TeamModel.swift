import Foundation
import SwiftData

// MARK: - Domain Model (Immutable, Pure)

struct TeamModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let players: [PlayerModel]
    let photoData: Data?
    let wins: Int
    let losses: Int

    func update(id: UUID, name: String, players: [PlayerModel], photoData: Data?) -> TeamModel {
        TeamModel(id: id, name: name, players: players, photoData: photoData, wins: wins, losses: losses)
    }

    // For navigation by value
    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SwiftData Entity (Mutable, Persistence-only)
@Model
final class TeamEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var players: [PlayerEntity]

    var photoData: Data?
    var wins: Int
    var losses: Int

    init(
        id: UUID = UUID(),
        name: String,
        players: [PlayerEntity] = [],
        photoData: Data? = nil,
        wins: Int = 0,
        losses: Int = 0
    ) {
        self.id = id
        self.name = name
        self.players = players
        self.photoData = photoData
        self.wins = wins
        self.losses = losses
    }
}

// MARK: - Conversions (Pure Functions)

extension TeamEntity {
    /// Convert entity → model
    func toModel() -> TeamModel {
        TeamModel(
            id: id,
            name: name,
            players: players.map { $0.toModel() },
            photoData: photoData,
            wins: wins,
            losses: losses
        )
    }
}

extension TeamModel {
    /// Convert model → entity
    func toEntity(context: ModelContext) -> TeamEntity {
        let entity = TeamEntity(
            id: id,
            name: name,
            photoData: photoData,
            wins: wins,
            losses: losses
        )
        entity.players = players.map { $0.toEntity(context: context) }
        return entity
    }
}
