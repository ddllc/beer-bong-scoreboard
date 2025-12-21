import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var game: GameModel
    @State private var isWinnerSheetPresented = false
    @State private var isActionsModalPresented = false

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
        ZStack(alignment: .center) {
            VStack {
                ScoreboardView(game: $game, isActionsModalPresented: $isActionsModalPresented)
                BeerPongTableView(game: $game, isActionsModalPresented: $isActionsModalPresented)
            }

            VStack(spacing: 20) {
                Button("Pause Game") {
                    dismiss()
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .buttonBorderShape(.roundedRectangle(radius: 8))

                Button("Cancel Game", role: .cancel) {
                    dismiss()
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .buttonBorderShape(.roundedRectangle(radius: 8))
            }
            .padding()
            .background(.secondary)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8
                )
            )
            .opacity(isActionsModalPresented ? 1 : 0)
            .frame(width: 200)
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
