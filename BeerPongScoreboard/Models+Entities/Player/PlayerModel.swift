import Foundation
import SwiftData

struct PlayerModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let team: String
    let photoData: Data?

    let rpsWins: Int
    let rpsTies: Int
    let rpsLosses: Int

    let successfulThrows: Int
    let missedThrows: Int

    let currentHotStreak: Int
    let longestHotStreak: Int
    let currentColdStreak: Int
    let longestColdStreak: Int

    let lastCupSuccessfulThrows: Int
    let lastCupMissedThrows: Int

    let rebuttalCupSuccessfulThrows: Int
    let rebuttalCupMissedThrows: Int

    var totalRPSPlayed: Int { rpsWins + rpsTies + rpsLosses }
    var totalThrows: Int { successfulThrows + missedThrows }

    var totalThrowSuccessPercentage: Double {
        guard totalThrows > 0 else { return 0 }
        return Double(successfulThrows) / Double(totalThrows)
    }

    var lastCupTotalThrowSuccessPercentage: Double {
        guard (lastCupSuccessfulThrows + lastCupMissedThrows) > 0 else { return 0 }
        return Double(lastCupSuccessfulThrows) / Double(lastCupSuccessfulThrows + lastCupMissedThrows)
    }

    var rebuttalCupTotalThrowSuccessPercentage: Double {
        guard (rebuttalCupSuccessfulThrows + rebuttalCupMissedThrows) > 0 else { return 0 }
        return Double(rebuttalCupSuccessfulThrows) / Double(rebuttalCupSuccessfulThrows + rebuttalCupMissedThrows)
    }
}

extension PlayerModel {
    func update(id: UUID, name: String, team: String, photoData: Data?) -> PlayerModel {
        PlayerModel(
            id: id,
            name: name,
            team: team,
            photoData: photoData,
            rpsWins: rpsWins,
            rpsTies: rpsTies,
            rpsLosses: rpsLosses,
            successfulThrows: successfulThrows,
            missedThrows: missedThrows,
            currentHotStreak: currentHotStreak,
            longestHotStreak: longestHotStreak,
            currentColdStreak: currentColdStreak,
            longestColdStreak: longestColdStreak,
            lastCupSuccessfulThrows: lastCupSuccessfulThrows,
            lastCupMissedThrows: lastCupMissedThrows,
            rebuttalCupSuccessfulThrows: rebuttalCupSuccessfulThrows,
            rebuttalCupMissedThrows: rebuttalCupMissedThrows
        )
    }

    func toEntity(context: ModelContext) -> PlayerEntity {
        let entity = PlayerEntity(
            id: id,
            name: name,
            team: team,
            photoData: photoData,
            rpsWins: rpsWins,
            rpsTies: rpsTies,
            rpsLosses: rpsLosses,
            successfulThrows: successfulThrows,
            missedThrows: missedThrows,
            currentHotStreak: currentHotStreak,
            longestHotStreak: longestHotStreak,
            currentColdStreak: currentColdStreak,
            longestColdStreak: longestColdStreak,
            lastCupSuccessfulThrows: lastCupSuccessfulThrows,
            lastCupMissedThrows: lastCupMissedThrows,
            rebuttalCupSuccessfulThrows: rebuttalCupSuccessfulThrows,
            rebuttalCupMissedThrows: rebuttalCupMissedThrows
        )
        return entity
    }

    static func == (lhs: PlayerModel, rhs: PlayerModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
