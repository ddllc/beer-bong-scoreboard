import Foundation
import SwiftData

@Model
final class TeamEntity {
    // MARK: - Identity
    @Attribute(.unique) var id: UUID
    var name: String

    // MARK: - Players
    // One-to-many relationship
    @Relationship(deleteRule: .cascade)
    var players: [PlayerEntity]

    // MARK: - Photo
    var photoData: Data?

    // MARK: - Record
    var wins: Int
    var losses: Int
    var overtimeWins: Int
    var overtimeLosses: Int

    // MARK: - Cups
    var totalCupsMade: Int
    var totalCupsOppenentsMade: Int

    // MARK: - Streaks
    var currentWinningStreak: Int
    var currentLosingStreak: Int
    var longestWinningStreak: Int
    var longestLosingStreak: Int
    var currentHotStreak: Int
    var currentColdStreak: Int
    var longestHotStreak: Int
    var longestColdStreak: Int

    // MARK: - Rule-specific stats
    var rebuttalAttempts: Int
    var successfulRebuttals: Int
    var bonusShotAttempts: Int
    var bonusShotMakes: Int

    // MARK: - Computed convenience
    var gamesPlayed: Int {
        wins + losses
    }

    init(
        id: UUID = UUID(),
        name: String,
        players: [PlayerEntity] = [],
        photoData: Data?,
        wins: Int,
        losses: Int,
        overtimeWins: Int,
        overtimeLosses: Int,
        totalCupsHit: Int,
        totalCupsHitAgainst: Int,
        currentWinningStreak: Int,
        currentLosingStreak: Int,
        longestWinningStreak: Int,
        longestLosingStreak: Int,
        currentHotStreak: Int,
        currentColdStreak: Int,
        longestHotStreak: Int,
        longestColdStreak: Int,
        rebuttalAttempts: Int,
        successfulRebuttals: Int,
        bonusShotAttempts: Int,
        bonusShotMakes: Int
    ) {
        self.id = id
        self.name = name
        self.players = players
        self.photoData = photoData
        self.wins = wins
        self.losses = losses
        self.overtimeWins = overtimeWins
        self.overtimeLosses = overtimeLosses
        self.totalCupsMade = totalCupsHit
        self.totalCupsOppenentsMade = totalCupsHitAgainst
        self.currentWinningStreak = currentWinningStreak
        self.currentLosingStreak = currentLosingStreak
        self.longestWinningStreak = longestWinningStreak
        self.longestLosingStreak = longestLosingStreak
        self.currentHotStreak = currentHotStreak
        self.currentColdStreak = currentColdStreak
        self.longestHotStreak = longestHotStreak
        self.longestColdStreak = longestColdStreak
        self.rebuttalAttempts = rebuttalAttempts
        self.successfulRebuttals = successfulRebuttals
        self.bonusShotAttempts = bonusShotAttempts
        self.bonusShotMakes = bonusShotMakes
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
}
