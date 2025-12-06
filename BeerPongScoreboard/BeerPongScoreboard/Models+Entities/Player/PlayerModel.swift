import Foundation

struct PlayerModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let team: String
    let photoData: Data?
}

extension PlayerModel {
    func update(
        name: String? = nil,
        team: String? = nil,
        photoData: Data? = nil
    ) -> PlayerModel {
        PlayerModel(
            id: id,
            name: name ?? self.name,
            team: team ?? self.team,
            photoData: photoData ?? self.photoData
        )
    }

    func toEntity() -> PlayerEntity {
        PlayerEntity(
            id: id,
            name: name,
            team: team,
            photoData: photoData
        )
    }

    static func == (lhs: PlayerModel, rhs: PlayerModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
