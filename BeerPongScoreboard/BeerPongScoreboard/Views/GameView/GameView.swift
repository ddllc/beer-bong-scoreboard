import SwiftUI

struct GameView: View {
    @State private var game: GameModel
    @State private var isWinnerSheetPresented = false

    private var durationText: String {
        let end = game.endedAt ?? Date()
        let seconds = Int(end.timeIntervalSince(game.startedAt))

        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        return String(format: "%d:%02d", minutes, remainingSeconds)
    }

    init(game: GameModel) {
        _game = State(initialValue: game)
    }

    var body: some View {

        VStack {
                ScoreboardView(game: $game)
                BeerPongTableView(game: $game)

            Spacer()
            }
        .navigationBarBackButtonHidden(true)
        .onChange(of: game.team1CupsSunk) { _, newValue in
            if newValue == 10 {
                game = game.update(endedAt: Date(), winnerTeamID: game.team1.id)
                isWinnerSheetPresented = true
            }
        }
        .onChange(of: game.team2CupsSunk) { _, newValue in
            if newValue == 10 {
                game = game.update(endedAt: Date(), winnerTeamID: game.team2.id)
                isWinnerSheetPresented = true
            }
        }
        .sheet(isPresented: $isWinnerSheetPresented) {
            WinnerSheetView(winningTeamName: game.winnerTeamID == game.team1.id ? game.team1.name : game.team2.name, scoreLine: "\(game.team1CupsSunk)-\(game.team2CupsSunk)", durationText: durationText)
        }
    }
}
