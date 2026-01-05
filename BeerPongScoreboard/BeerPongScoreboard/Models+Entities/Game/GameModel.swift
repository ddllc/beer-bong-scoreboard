import Foundation

struct GameModel: Identifiable {
    let id: UUID
    let startedAt: Date
    let endedAt: Date?
    let team1: TeamModel
    let team2: TeamModel
    let team1CupsSunk: Int
    let team2CupsSunk: Int
    let startingTeamID: UUID
    let winnerTeamID: UUID?

    var durationMinuteSecondString: String {
        let timeInterval: TimeInterval = self.endedAt!.timeIntervalSince(self.startedAt)
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval).remainderReportingOverflow(dividingBy: 60).partialValue
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension GameModel {
    // MARK: - Immutable update API
    func update(
        startedAt: Date? = nil,
        endedAt: Date? = nil,
        team1: TeamModel? = nil,
        team2: TeamModel? = nil,
        team1CupsSunk: Int? = nil,
        team2CupsSunk: Int? = nil,
        startingTeamID: UUID? = nil,
        winnerTeamID: UUID? = nil
    ) -> GameModel {
        GameModel(
            id: self.id,  // ID never changes
            startedAt: startedAt ?? self.startedAt,
            endedAt: endedAt ?? self.endedAt,
            team1: team1 ?? self.team1,
            team2: team2 ?? self.team2,
            team1CupsSunk: team1CupsSunk ?? self.team1CupsSunk,
            team2CupsSunk: team2CupsSunk ?? self.team2CupsSunk,
            startingTeamID: startingTeamID ?? self.startingTeamID,
            winnerTeamID: winnerTeamID ?? self.winnerTeamID
        )
    }

    func toEntity(team1Entity: TeamEntity, team2Entity: TeamEntity) -> GameEntity {
        GameEntity(
            id: id,
            startedAt: startedAt,
            endedAt: endedAt,
            team1: team1Entity,
            team2: team2Entity,
            team1CupsSunk: team1CupsSunk,
            team2CupsSunk: team2CupsSunk,
            startingTeamID: startingTeamID,
            winnerTeamID: winnerTeamID
        )
    }
}
