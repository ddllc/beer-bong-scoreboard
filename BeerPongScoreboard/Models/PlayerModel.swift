import Foundation
import SwiftData

// MARK: - Domain Model (Immutable, Pure)

struct PlayerModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let team: String
    let photoData: Data?   // ✅ added

    func update(id: UUID, name: String, team: String, photoData: Data?) -> PlayerModel {
        PlayerModel(id: id, name: name, team: team, photoData: photoData)
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
    var photoData: Data?   // ✅ added

    init(id: UUID = UUID(), name: String, team: String, photoData: Data? = nil) {
        self.id = id
        self.name = name
        self.team = team
        self.photoData = photoData
    }
}

// MARK: - Conversions (Pure Functions)

extension PlayerEntity {
    /// entity → model
    func toModel() -> PlayerModel {
        PlayerModel(
            id: id,
            name: name,
            team: team,
            photoData: photoData   // ✅ added
        )
    }
}

extension PlayerModel {
    /// model → entity
    func toEntity(context: ModelContext) -> PlayerEntity {
        PlayerEntity(
            id: id,
            name: name,
            team: team,
            photoData: photoData   // ✅ added
        )
    }
}
