import Foundation

struct TeamModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let players: [PlayerModel]
    let photoData: Data?
    let wins: Int
    let losses: Int
    let totalCupsSunk: Int
    let totalCupsAllowed: Int
    let dateCreated: Date
}

extension TeamModel {
    func update(
        name: String? = nil,
        players: [PlayerModel]? = nil,
        photoData: Data? = nil,
        wins: Int? = nil,
        losses: Int? = nil,
        totalCupsSunk: Int? = nil,
        totalCupsAllowed: Int? = nil
    ) -> TeamModel {
        TeamModel(
            id: self.id,
            name: name ?? self.name,
            players: players ?? self.players,
            photoData: photoData ?? self.photoData,
            wins: wins ?? self.wins,
            losses: losses ?? self.losses,
            totalCupsSunk: totalCupsSunk ?? self.totalCupsSunk,
            totalCupsAllowed: totalCupsAllowed ?? self.totalCupsAllowed,
            dateCreated: self.dateCreated
        )
    }

    func toEntity() -> TeamEntity {
        TeamEntity(
            id: id,
            name: name,
            players: [],
            photoData: photoData,
            wins: wins,
            losses: losses,
            totalCupsSunk: totalCupsSunk,
            totalCupsAllowed: totalCupsAllowed,
            dateCreated: dateCreated
        )
    }

    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
