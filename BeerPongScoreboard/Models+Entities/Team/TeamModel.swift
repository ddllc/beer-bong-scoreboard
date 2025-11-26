import Foundation
import SwiftData

// MARK: - Domain Model (Immutable, Pure)

struct TeamModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let players: [PlayerModel]
    let photoData: Data?

    // Record
    let wins: Int
    let losses: Int
    let overtimeWins: Int
    let overtimeLosses: Int

    // Cups
    let totalCupsMade: Int          // across all games
    let totalCupsOppenentsMade: Int   // cups opponents hit vs this team

    // Streaks
    let currentWinningStreak: Int
    let currentLosingStreak: Int
    let longestWinningStreak: Int
    let longestLosingStreak: Int
    let currentHotStreak: Int
    let currentColdStreak: Int
    let longestHotStreak: Int
    let longestColdStreak: Int

    // Rule-specific stats
    let rebuttalAttempts: Int
    let successfulRebuttals: Int   // games where rebuttal forced OT

    let bonusShotAttempts: Int     // “both teammates hit” extra ball
    let bonusShotMakes: Int

    // Computed
    var gamesPlayed: Int { wins + losses }

    var winRate: Double {
        guard gamesPlayed > 0 else { return 0 }
        return Double(wins) / Double(gamesPlayed)
    }

    var averageCupDifferential: Double {
        guard gamesPlayed > 0 else { return 0 }
        let diff = totalCupsMade - totalCupsOppenentsMade
        return Double(diff) / Double(gamesPlayed)
    }
}

extension TeamModel {
    func toEntity(context: ModelContext) -> TeamEntity {
        let entity = TeamEntity(
            id: id,
            name: name,
            players: [], // will assign below if needed elsewhere
            photoData: photoData,
            wins: wins,
            losses: losses,
            overtimeWins: overtimeWins,
            overtimeLosses: overtimeLosses,
            totalCupsHit: totalCupsMade,
            totalCupsHitAgainst: totalCupsOppenentsMade,
            currentWinningStreak: currentWinningStreak,
            currentLosingStreak: currentLosingStreak,
            longestWinningStreak: longestWinningStreak,
            longestLosingStreak: longestLosingStreak,
            currentHotStreak: currentHotStreak,
            currentColdStreak: currentColdStreak,
            longestHotStreak: longestHotStreak,
            longestColdStreak: longestColdStreak,
            rebuttalAttempts: rebuttalAttempts,
            successfulRebuttals: successfulRebuttals,
            bonusShotAttempts: bonusShotAttempts,
            bonusShotMakes: bonusShotMakes
        )
        return entity
    }

    func update(id: UUID, name: String, players: [PlayerModel], photoData: Data?) -> TeamModel {
        TeamModel(
            id: id,
            name: name,
            players: players,
            photoData: photoData,
            wins: wins,
            losses: losses,
            overtimeWins: overtimeWins,
            overtimeLosses: overtimeLosses,
            totalCupsMade: totalCupsMade,
            totalCupsOppenentsMade: totalCupsOppenentsMade,
            currentWinningStreak: currentWinningStreak,
            currentLosingStreak: currentLosingStreak,
            longestWinningStreak: longestWinningStreak,
            longestLosingStreak: longestLosingStreak,
            currentHotStreak: currentHotStreak,
            currentColdStreak: currentColdStreak,
            longestHotStreak: longestHotStreak,
            longestColdStreak: longestColdStreak,
            rebuttalAttempts: rebuttalAttempts,
            successfulRebuttals: successfulRebuttals,
            bonusShotAttempts: bonusShotAttempts,
            bonusShotMakes: bonusShotMakes
        )
    }

    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
