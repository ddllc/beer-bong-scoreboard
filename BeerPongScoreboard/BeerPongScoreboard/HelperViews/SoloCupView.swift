import SwiftUI

struct SoloCupView: View {
    @Environment(AppData.self) private var appData: AppData

    let teamNumber: Int
    let cupID: Int
    let soloCupColor: SoloCupColor

    var isSunk: Bool {
        // Fetch current status from correct team's array
        let cups = teamNumber == 1 ? appData.team1Cups : appData.team2Cups
        return cups.first(where: { $0.id == cupID })?.isSunk ?? false
    }

    var body: some View {
        Button {
            appData.toggleCupSunkState(forTeam: teamNumber, withID: cupID)
        } label: {
            Image(soloCupColor == .red ? "SoloCupRed" : "SoloCupBlue")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .rotationEffect(isSunk ? Angle(degrees: -90) : .zero)
        }
    }
}

#Preview("SoloCupRed") {
    // For preview, use a temporary AppData environment
    SoloCupView(teamNumber: 1, cupID: 1, soloCupColor: .red)
        .environment(AppData())
}

#Preview("SoloCupBlue") {
    SoloCupView(teamNumber: 2, cupID: 1, soloCupColor: .blue)
        .environment(AppData())
}
