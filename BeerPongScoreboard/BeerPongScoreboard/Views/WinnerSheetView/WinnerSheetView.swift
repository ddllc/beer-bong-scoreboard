import SwiftUI

struct WinnerSheetView: View {
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss
    let game: GameModel

    private var isTeamOneWinner: Bool { game.winnerTeamID == game.team1.id }
    private var isTeamTwoWinner: Bool { game.winnerTeamID == game.team2.id }

    private var team1UIImage: UIImage? {
        guard let data = game.team1.photoData else { return nil }
        return UIImage(data: data)
    }

    private var team2UIImage: UIImage? {
        guard let data = game.team2.photoData else { return nil }
        return UIImage(data: data)
    }

    var body: some View {
        ScrollView {
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    trophyView
                    Spacer()
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("\(isTeamOneWinner ? game.team1.name : game.team2.name) WINS!")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Game Duration: \(game.durationMinuteSecondString)")
                                .foregroundStyle(.secondary)
                        }

                        Divider()

                        Text("Team Stats")
                            .font(.title)
                            .bold()
                        HStack(spacing: 32) {
                            VStack {
                                Text(game.team1.name)
                                    .font(.title3)
                                    .bold()
                                Text("Total Wins: \(game.team1.wins)")
                                Text("Total Losses: \(game.team1.losses)")
                            }
                            VStack {
                                Text(game.team2.name)
                                    .font(.title3)
                                    .bold()
                                Text("Total Wins: \(game.team2.wins)")
                                Text("Total Losses: \(game.team2.losses)")
                            }
                        }
                    }
                    Spacer()
                }
                .padding()


                Spacer()
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
    }

    private var trophyView: some View {
        ZStack(alignment: .top) {
            Image(systemName: "trophy.fill")
                .foregroundStyle(.yellow)
                .font(.system(size: 200))

            VStack {
                if isTeamOneWinner {
                    if let uiImage = team1UIImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.9), lineWidth: 2))
                            .padding(.top, 20)
                    } else {
                        Text(game.team1.name)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else if isTeamTwoWinner {
                    if let uiImage = team2UIImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.9), lineWidth: 2))
                            .padding(.top, 20)
                    } else {
                        Text(game.team2.name)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }

                Spacer()

                HStack {
                    Text("\(isTeamOneWinner ? game.team1CupsSunk : game.team2CupsSunk)")
                    Text("—")
                    Text("\(isTeamOneWinner ? game.team2CupsSunk : game.team1CupsSunk)")
                }
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.bottom, 20)
            }
        }
    }
}





            //                VStack(alignment: .leading, spacing: 6) {
            //
            //                    Text("Game Stats")
            //                        .font(.headline)
            //
            //                    Text("Game ID: \(game.id.uuidString)")
            //                    Text("Started At: \(game.startedAt.formatted())")
            //                    Text("Starting Team ID: \(game.startingTeamID.uuidString)")
            //
            //                    Text("Ended At: \(game.endedAt?.formatted() ?? "In Progress")")
            //                    Text("Winner Team ID: \(game.winnerTeamID?.uuidString ?? "None")")
            //
            //                    Text("Score: \(game.team1CupsSunk) - \(game.team2CupsSunk)")
            //
            //                    Divider()
            //
            //                    Text("Team 1")
            //                        .font(.subheadline)
            //                        .bold()
            //
            //                    Text("ID: \(game.team1.id.uuidString)")
            //                    Text("Name: \(game.team1.name)")
            //                    Text("Created: \(game.team1.dateCreated.formatted())")
            //                    Text("Wins: \(game.team1.wins)")
            //                    Text("Losses: \(game.team1.losses)")
            //                    Text("Total Cups Sunk: \(game.team1.totalCupsSunk)")
            //                    Text("Total Cups Allowed: \(game.team1.totalCupsAllowed)")
            //                    Text("Players: \(game.team1.players.map { $0.name }.joined(separator: ", "))")
            //                    Text("Has Photo: \(game.team1.photoData != nil ? "Yes" : "No")")
            //
            //                    Divider()
            //
            //                    Text("Team 2")
            //                        .font(.subheadline)
            //                        .bold()
            //
            //                    Text("ID: \(game.team2.id.uuidString)")
            //                    Text("Name: \(game.team2.name)")
            //                    Text("Created: \(game.team2.dateCreated.formatted())")
            //                    Text("Wins: \(game.team2.wins)")
            //                    Text("Losses: \(game.team2.losses)")
            //                    Text("Total Cups Sunk: \(game.team2.totalCupsSunk)")
            //                    Text("Total Cups Allowed: \(game.team2.totalCupsAllowed)")
            //                    Text("Players: \(game.team2.players.map { $0.name }.joined(separator: ", "))")
            //                    Text("Has Photo: \(game.team2.photoData != nil ? "Yes" : "No")")
            //                }


//

//        }
//        .padding()
//        .toolbar {
//            Button("Go Back", role: .cancel) {
//                dismiss()
//            }
//        }
//    }
//}
