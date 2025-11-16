import SwiftUI

struct SoloCupModel {
    let id: Int
    let soloCupNumber: Int
    let soloCupColor: SoloCupColor
    let isSunk: Bool

    private func updateSoloCupModel(
        id: Int, soloCupNumber: Int,
        soloCupColor: SoloCupColor,
        isSunk: Bool) -> SoloCupModel {
            SoloCupModel(id: id, soloCupNumber: soloCupNumber, soloCupColor: soloCupColor, isSunk: isSunk)
    }
}


enum SoloCupColor: String {
    case red
    case blue
}
