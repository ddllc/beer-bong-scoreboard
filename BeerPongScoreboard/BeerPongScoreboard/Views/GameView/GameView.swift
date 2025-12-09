import SwiftUI

struct GameView: View {
    let game: GameModel
    private let totalCups = 10

    var body: some View {
        VStack(spacing: 32) {
            // Matchup Title
            VStack(spacing: 4) {
                Text("\(game.team1.name) vs \(game.team2.name)")
                    .font(.title)
                    .fontWeight(.bold)
                Text("First throw: \(game.startingTeamID == game.team1.id ? game.team1.name : game.team2.name)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            // Team 1 row
            VStack(spacing: 8) {
                Text(game.team1.name)
                    .font(.headline)
                cupsRow(cupsSunk: game.team1CupsSunk, tint: .soloCupRed)
            }

            // Team 2 row
            VStack(spacing: 8) {
                Text(game.team2.name)
                    .font(.headline)
                cupsRow(cupsSunk: game.team2CupsSunk, tint: .soloCupBlue)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Scoreboard")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helpers

    private func cupsRow(cupsSunk: Int, tint: Color) -> some View {
        HStack(spacing: 8) {
            ForEach(0..<totalCups, id: \.self) { index in
                Image(systemName: index < cupsSunk ? "circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(tint)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(cupsSunk) of \(totalCups) cups sunk")
    }
}
