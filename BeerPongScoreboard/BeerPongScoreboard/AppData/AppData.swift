import SwiftUI

@Observable
class AppData {
    var isRerackEnabled = false
    var isTurnIndicatorEnabled = false
    var currentTurnTeamID: UUID?
    




    var team1Cups: [SoloCupModel] = (1...10).map {
        SoloCupModel(id: $0, soloCupNumber: $0, soloCupColor: .red, isSunk: false)
    }
    var team2Cups: [SoloCupModel] = (1...10).map {
        SoloCupModel(id: $0, soloCupNumber: $0, soloCupColor: .blue, isSunk: false)
    }
        var currentTurnIndex: Int = 1
    var roundNumber: Int = 1

    var team1AmountOfSunkCups: Int {
        team1Cups.filter { $0.isSunk }.count
    }
    var team2AmountOfSunkCups: Int {
        team2Cups.filter { $0.isSunk }.count
    }


}


extension AppData {
    func toggleCupSunkState(forTeam team: Int, withID id: Int) {
        switch team {
        case 1:
            if let cupIndex = team1Cups.firstIndex(where: { $0.id == id }) {
                let oldCup = team1Cups[cupIndex]
                let updatedCup = SoloCupModel(
                    id: oldCup.id,
                    soloCupNumber: oldCup.soloCupNumber,
                    soloCupColor: oldCup.soloCupColor,
                    isSunk: !oldCup.isSunk
                )
                team1Cups[cupIndex] = updatedCup
            }
        case 2:
            if let cupIndex = team2Cups.firstIndex(where: { $0.id == id }) {
                let oldCup = team2Cups[cupIndex]
                let updatedCup = SoloCupModel(
                    id: oldCup.id,
                    soloCupNumber: oldCup.soloCupNumber,
                    soloCupColor: oldCup.soloCupColor,
                    isSunk: !oldCup.isSunk
                )
                team2Cups[cupIndex] = updatedCup
            }
        default:
            break
        }
    }
}
