import Foundation
import SwiftData

@Model
final class PlayerEntity {
    @Attribute(.unique) var id: UUID
    var name: String
    var team: String
    var photoData: Data?
    var rpsWins: Int
    var rpsTies: Int
    var rpsLosses: Int
    var successfulThrows: Int
    var missedThrows: Int
    var currentHotStreak: Int
    var longestHotStreak: Int
    var currentColdStreak: Int
    var longestColdStreak: Int
    var lastCupSuccessfulThrows: Int
    var lastCupMissedThrows: Int
    var rebuttalCupSuccessfulThrows: Int
    var rebuttalCupMissedThrows: Int

    init(
        id: UUID,
        name: String,
        team: String,
        photoData: Data? = nil,
        rpsWins: Int,
        rpsTies: Int,
        rpsLosses: Int,
        successfulThrows: Int,
        missedThrows: Int,
        currentHotStreak: Int,
        longestHotStreak: Int,
        currentColdStreak: Int,
        longestColdStreak: Int,
        lastCupSuccessfulThrows: Int,
        lastCupMissedThrows: Int,
        rebuttalCupSuccessfulThrows: Int,
        rebuttalCupMissedThrows: Int
    ) {
        self.id = id
        self.name = name
        self.team = team
        self.photoData = photoData
        self.rpsWins = rpsWins
        self.rpsTies = rpsTies
        self.rpsLosses = rpsLosses
        self.successfulThrows = successfulThrows
        self.missedThrows = missedThrows
        self.currentHotStreak = currentHotStreak
        self.longestHotStreak = longestHotStreak
        self.currentColdStreak = currentColdStreak
        self.longestColdStreak = longestColdStreak
        self.lastCupSuccessfulThrows = lastCupSuccessfulThrows
        self.lastCupMissedThrows = lastCupMissedThrows
        self.rebuttalCupSuccessfulThrows = rebuttalCupSuccessfulThrows
        self.rebuttalCupMissedThrows = rebuttalCupMissedThrows
    }
}

extension PlayerEntity {
    func toModel() -> PlayerModel {
        PlayerModel(
            id: id,
            name: name,
            team: team,
            photoData: photoData,
            rpsWins: 0,
            rpsTies: 0,
            rpsLosses: 0,
            successfulThrows: 0,
            missedThrows: 0,
            currentHotStreak: 0,
            longestHotStreak: 0,
            currentColdStreak: 0,
            longestColdStreak: 0,
            lastCupSuccessfulThrows: 0,
            lastCupMissedThrows: 0,
            rebuttalCupSuccessfulThrows: 0,
            rebuttalCupMissedThrows: 0
        )
    }
}
