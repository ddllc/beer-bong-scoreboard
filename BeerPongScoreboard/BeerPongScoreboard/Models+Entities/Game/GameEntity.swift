import Foundation
import SwiftData

@Model
final class GameEntity {
    @Attribute(.unique) var id: UUID
    var startedAt: Date
    var endedAt: Date?
    var team1: TeamEntity
    var team2: TeamEntity
    var team1CupsSunk: Int
    var team2CupsSunk: Int
    var startingTeamID: UUID
    var winnerTeamID: UUID?

    init(
        id: UUID = UUID(),
        startedAt: Date,
        endedAt: Date? = nil,
        team1: TeamEntity,
        team2: TeamEntity,
        team1CupsSunk: Int,
        team2CupsSunk: Int,
        startingTeamID: UUID,
        winnerTeamID: UUID? = nil
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.team1 = team1
        self.team2 = team2
        self.team1CupsSunk = team1CupsSunk
        self.team2CupsSunk = team2CupsSunk
        self.startingTeamID = startingTeamID
        self.winnerTeamID = winnerTeamID
    }
}

extension GameEntity {
    func toModel() -> GameModel {
        GameModel(
            id: id,
            startedAt: startedAt,
            endedAt: endedAt,
            team1: team1.toModel(),
            team2: team2.toModel(),
            team1CupsSunk: team1CupsSunk,
            team2CupsSunk: team2CupsSunk,
            startingTeamID: startingTeamID,
            winnerTeamID: winnerTeamID
        )
    }
}
