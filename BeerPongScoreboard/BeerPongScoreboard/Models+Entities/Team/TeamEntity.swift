import Foundation
import SwiftData

@Model
final class TeamEntity {
    @Attribute(.unique) var id: UUID

    var name: String
    var players: [PlayerEntity]
    var photoData: Data?
    var wins: Int
    var losses: Int
    var totalCupsSunk: Int
    var totalCupsAllowed: Int
    var dateCreated: Date

    init(
        id: UUID = UUID(),
        name: String,
        players: [PlayerEntity] = [],
        photoData: Data? = nil,
        wins: Int = 0,
        losses: Int = 0,
        totalCupsSunk: Int = 0,
        totalCupsAllowed: Int = 0,
        dateCreated: Date = .now
    ) {
        self.id = id
        self.name = name
        self.players = players
        self.photoData = photoData
        self.wins = wins
        self.losses = losses
        self.totalCupsSunk = totalCupsSunk
        self.totalCupsAllowed = totalCupsAllowed
        self.dateCreated = dateCreated
    }
}

extension TeamEntity {
    func toModel() -> TeamModel {
        TeamModel(
            id: id,
            name: name,
            players: players.map { $0.toModel() },
            photoData: photoData,
            wins: wins,
            losses: losses,
            totalCupsSunk: totalCupsSunk,
            totalCupsAllowed: totalCupsAllowed,
            dateCreated: dateCreated
        )
    }
}
