import SwiftUI

struct WinnerSheetView: View {
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss
    let game: GameModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {

                    Text("Game Stats")
                        .font(.headline)

                    Text("Game ID: \(game.id.uuidString)")
                    Text("Started At: \(game.startedAt.formatted())")
                    Text("Starting Team ID: \(game.startingTeamID.uuidString)")

                    Text("Ended At: \(game.endedAt?.formatted() ?? "In Progress")")
                    Text("Winner Team ID: \(game.winnerTeamID?.uuidString ?? "None")")

                    Text("Score: \(game.team1CupsSunk) - \(game.team2CupsSunk)")

                    Divider()

                    Text("Team 1")
                        .font(.subheadline)
                        .bold()

                    Text("ID: \(game.team1.id.uuidString)")
                    Text("Name: \(game.team1.name)")
                    Text("Created: \(game.team1.dateCreated.formatted())")
                    Text("Wins: \(game.team1.wins)")
                    Text("Losses: \(game.team1.losses)")
                    Text("Total Cups Sunk: \(game.team1.totalCupsSunk)")
                    Text("Total Cups Allowed: \(game.team1.totalCupsAllowed)")
                    Text("Players: \(game.team1.players.map { $0.name }.joined(separator: ", "))")
                    Text("Has Photo: \(game.team1.photoData != nil ? "Yes" : "No")")

                    Divider()

                    Text("Team 2")
                        .font(.subheadline)
                        .bold()

                    Text("ID: \(game.team2.id.uuidString)")
                    Text("Name: \(game.team2.name)")
                    Text("Created: \(game.team2.dateCreated.formatted())")
                    Text("Wins: \(game.team2.wins)")
                    Text("Losses: \(game.team2.losses)")
                    Text("Total Cups Sunk: \(game.team2.totalCupsSunk)")
                    Text("Total Cups Allowed: \(game.team2.totalCupsAllowed)")
                    Text("Players: \(game.team2.players.map { $0.name }.joined(separator: ", "))")
                    Text("Has Photo: \(game.team2.photoData != nil ? "Yes" : "No")")
                }



                // MARK: - End Game Button
                VStack {
                    Button(role: .confirm) {
                        
                    } label: {
                        Text("End Game")
                            .font(.title)
                            .bold()
                    }
                    .buttonStyle(.glassProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 8))
                    .buttonSizing(.flexible)
                }
            }
            .padding()
            .toolbar {
                Button("Go Back", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}
