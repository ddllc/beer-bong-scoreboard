import Foundation
import SwiftData

// MARK: - Domain Model (Immutable, Pure)

struct PlayerModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let team: String

    func update(id: UUID, name: String, team: String) -> PlayerModel {
        PlayerModel(id: id, name: name, team: team)
    }

    static func == (lhs: PlayerModel, rhs: PlayerModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SwiftData Entity (Mutable, Persistence-only)

@Model
final class PlayerEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var team: String

    init(id: UUID = UUID(), name: String, team: String) {
        self.id = id
        self.name = name
        self.team = team
    }
}

// MARK: - Conversions (Pure Functions)

extension PlayerEntity {
    /// entity → model
    func toModel() -> PlayerModel {
        PlayerModel(
            id: id,
            name: name,
            team: team
        )
    }
}

extension PlayerModel {
    /// model → entity
    func toEntity(context: ModelContext) -> PlayerEntity {
        PlayerEntity(
            id: id,
            name: name,
            team: team
        )
    }
}
