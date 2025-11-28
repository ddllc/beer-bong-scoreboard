import SwiftUI
import SwiftData

struct RockPaperScissorsView: View {
    let team1: TeamEntity
    let team2: TeamEntity

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var isRPSDecided = false

    // MARK: - State

    @State private var team1Choice: RPSChoice?
    @State private var team2Choice: RPSChoice?
    @State private var resultText: String = "Pick a player and Rock, Paper, or Scissors for each team to see who goes first!"

    @State private var team1SelectedPlayer: PlayerEntity?
    @State private var team2SelectedPlayer: PlayerEntity?

    var body: some View {
        VStack {
            Text("Rock • Paper • Scissors")
                .font(.largeTitle.bold())

            Text(resultText)
                .multilineTextAlignment(.center)
                .lineLimit(nil)


            Spacer()

            VStack(spacing: 20) {
                // MARK: Team 1 section
                HStack(spacing: 8) {
                    Text(team1.name)
                        .font(.title3.bold())

                    // Player picker
                    if !team1.players.isEmpty {
                        Menu {
                            ForEach(team1.players) { player in
                                Button(player.name) {
                                    team1SelectedPlayer = player
                                    determineRPSWinner()
                                }
                            }
                        } label: {
                            HStack {
                                Text(team1SelectedPlayer?.name ?? "Choose player")
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }

                    // RPS choices
                    HStack {
                        ForEach(RPSChoice.allCases, id: \.self) { choice in
                            Button(choice.rawValue) {
                                team1Choice = choice
                                determineRPSWinner()
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                team1Choice == choice
                                ? Color.blue.opacity(0.3)
                                : Color.gray.opacity(0.15)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }

                // MARK: Team 2 section
                HStack(spacing: 8) {
                    Text(team2.name)
                        .font(.title3.bold())

                    // Player picker
                    if !team2.players.isEmpty {
                        Menu {
                            ForEach(team2.players) { player in
                                Button(player.name) {
                                    team2SelectedPlayer = player
                                    determineRPSWinner()
                                }
                            }
                        } label: {
                            HStack {
                                Text(team2SelectedPlayer?.name ?? "Choose player")
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }

                    // RPS choices
                    HStack {
                        ForEach(RPSChoice.allCases, id: \.self) { choice in
                            Button(choice.rawValue) {
                                team2Choice = choice
                                determineRPSWinner()
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                team2Choice == choice
                                ? Color.green.opacity(0.3)
                                : Color.gray.opacity(0.15)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            Spacer()

            NavigationLink(destination: GameView()) {
                Text("Start Game")
            }
            .buttonStyle(.glassProminent)
            .buttonSizing(.flexible)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .padding()
            .disabled(isRPSDecided)

        }
        .padding()
    }

    // MARK: - Logic

    private func determineRPSWinner() {
        guard
            let team1Choice = team1Choice,
            let team2Choice = team2Choice,
            let team1SelectedPlayer = team1SelectedPlayer,
            let team2SelectedPlayer = team2SelectedPlayer
        else {
            resultText = "Pick a player AND a choice for each team."
            return
        }

        guard team1Choice == team2Choice else {
            resultText = "It's a tie! Change a choice to play again."
            applyRPSResult(result: .tie, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team1SelectedPlayer)
            return
        }

        if team1Choice == .rock, team2Choice == .paper {
            resultText = "\(team1SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team1Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        } else if team2Choice == .rock, team1Choice == .paper {
            resultText = "\(team2SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team2Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        }

        if team1Choice == .rock, team2Choice == .scissors {
            resultText = "\(team1SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team1Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        } else if team2Choice == .scissors, team1Choice == .rock {
            resultText = "\(team2SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team2Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        }

        if team1Choice == .scissors, team2Choice == .paper {
            resultText = "\(team1SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team1Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        } else if team2Choice == .paper, team1Choice == .scissors {
            resultText = "\(team2SelectedPlayer.team) Goes First!"
            applyRPSResult(result: .team2Win, team1SelectedPlayer: team1SelectedPlayer, team2SelectedPlayer: team2SelectedPlayer)
        }
    }


    private func applyRPSResult(
        result: RPSResult,
        team1SelectedPlayer: PlayerEntity,
        team2SelectedPlayer: PlayerEntity
    ) {
        switch result {
        case .tie:
            team1SelectedPlayer.rpsTies += 1
            team2SelectedPlayer.rpsTies += 1
        case .team1Win:
            team1SelectedPlayer.rpsWins += 1
            team2SelectedPlayer.rpsLosses += 1
            isRPSDecided = true
        case .team2Win:
            team1SelectedPlayer.rpsLosses += 1
            team2SelectedPlayer.rpsWins += 1
            isRPSDecided = true
        }

        do {
            try modelContext.save()
        } catch {
            print("⚠️ Failed to save RPS stats: \(error)")
        }
    }

    private enum RPSResult {
        case team1Win
        case team2Win
        case tie
    }

    private enum RPSChoice: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }
}
