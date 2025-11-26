import Foundation
import SwiftData

// MARK: - Supporting Types

enum TeamTurn: Int, Codable {
    case team1 = 1
    case team2 = 2
}

// MARK: - Domain Model (Immutable, Pure)

struct GameModel: Identifiable, Hashable {
    let id: UUID
    let startedAt: Date
    let endedAt: Date?

    let team1: TeamModel
    let team2: TeamModel

    /// Aggregate state for history / stats (your SoloCupModel arrays live in AppData)
    let team1CupsSunk: Int
    let team2CupsSunk: Int

    /// Who started the game (for fairness / stats)
    let startingTeam: TeamTurn

    /// Who won (nil until game is finished)
    let winnerTeam: TeamTurn?

    // For navigation by value
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SwiftData Entity (Mutable, Persistence-only)

@Model
final class GameEntity {
    @Attribute(.unique) var id: UUID

    var startedAt: Date
    var endedAt: Date?

    // Relationships to teams
    var team1: TeamEntity?
    var team2: TeamEntity?

    // Aggregate game state
    var team1CupsSunk: Int
    var team2CupsSunk: Int

    // Raw storage for enum values
    var startingTeamRaw: Int
    var winnerTeamRaw: Int?

    init(
        id: UUID = UUID(),
        startedAt: Date = Date(),
        endedAt: Date? = nil,
        team1: TeamEntity? = nil,
        team2: TeamEntity? = nil,
        team1CupsSunk: Int = 0,
        team2CupsSunk: Int = 0,
        startingTeamRaw: Int = TeamTurn.team1.rawValue,
        winnerTeamRaw: Int? = nil
    ) {
        self.id = id
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.team1 = team1
        self.team2 = team2
        self.team1CupsSunk = team1CupsSunk
        self.team2CupsSunk = team2CupsSunk
        self.startingTeamRaw = startingTeamRaw
        self.winnerTeamRaw = winnerTeamRaw
    }
}

// MARK: - Conversions (Pure Functions)

extension GameEntity {
    /// entity → model
    ///
    /// Returns `nil` if either team is missing (corrupt / partial data).
    func toModel() -> GameModel? {
        guard let team1, let team2 else {
            return nil
        }

        let startingTeam = TeamTurn(rawValue: startingTeamRaw) ?? .team1
        let winnerTeam = winnerTeamRaw.flatMap { TeamTurn(rawValue: $0) }

        return GameModel(
            id: id,
            startedAt: startedAt,
            endedAt: endedAt,
            team1: team1.toModel(),
            team2: team2.toModel(),
            team1CupsSunk: team1CupsSunk,
            team2CupsSunk: team2CupsSunk,
            startingTeam: startingTeam,
            winnerTeam: winnerTeam
        )
    }
}

extension GameModel {
    /// model → entity
    ///
    /// You pass the `TeamEntity` instances you want this game associated with.
    /// (usually looked up or created beforehand)
    func toEntity(
        context: ModelContext,
        team1Entity: TeamEntity,
        team2Entity: TeamEntity
    ) -> GameEntity {
        GameEntity(
            id: id,
            startedAt: startedAt,
            endedAt: endedAt,
            team1: team1Entity,
            team2: team2Entity,
            team1CupsSunk: team1CupsSunk,
            team2CupsSunk: team2CupsSunk,
            startingTeamRaw: startingTeam.rawValue,
            winnerTeamRaw: winnerTeam?.rawValue
        )
    }
}
