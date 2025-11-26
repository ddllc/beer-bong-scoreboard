import SwiftUI
import SwiftData

struct RockPaperScissorsView: View {
    let team1: TeamEntity
    let team2: TeamEntity

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    private enum RPSChoice: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }

    // MARK: - State

    @State private var team1Choice: RPSChoice?
    @State private var team2Choice: RPSChoice?
    @State private var resultText: String = "Pick a player and Rock, Paper, or Scissors for each team."

    @State private var team1SelectedPlayer: PlayerEntity?
    @State private var team2SelectedPlayer: PlayerEntity?

    var body: some View {
        VStack(spacing: 24) {
            Text("Rock • Paper • Scissors")
                .font(.largeTitle.bold())

            // MARK: Team 1 section
            VStack(spacing: 8) {
                Text(team1.name)
                    .font(.title3.bold())

                // Player picker
                if !team1.players.isEmpty {
                    Menu {
                        ForEach(team1.players) { player in
                            Button(player.name) {
                                team1SelectedPlayer = player
                                updateResultIfReady()
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
                            updateResultIfReady()
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
            VStack(spacing: 8) {
                Text(team2.name)
                    .font(.title3.bold())

                // Player picker
                if !team2.players.isEmpty {
                    Menu {
                        ForEach(team2.players) { player in
                            Button(player.name) {
                                team2SelectedPlayer = player
                                updateResultIfReady()
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
                            updateResultIfReady()
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

            Divider()

            // MARK: Result
            Text(resultText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button("Done") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }

    // MARK: - Logic

    private func updateResultIfReady() {
        guard
            let c1 = team1Choice,
            let c2 = team2Choice,
            let p1 = team1SelectedPlayer,
            let p2 = team2SelectedPlayer
        else {
            resultText = "Pick a player AND a choice for each team."
            return
        }

        if c1 == c2 {
            resultText = """
            \(team1.name) (\(p1.name)) chose \(c1.rawValue).
            \(team2.name) (\(p2.name)) chose \(c2.rawValue).

            It's a tie! Change a choice to play again.
            """
            applyRPSResult(result: .tie, player1: p1, player2: p2)
            return
        }

        let team1Wins =
            (c1 == .rock && c2 == .scissors) ||
            (c1 == .paper && c2 == .rock) ||
            (c1 == .scissors && c2 == .paper)

        let winnerTeamName = team1Wins ? team1.name : team2.name
        let winnerPlayerName = team1Wins ? p1.name : p2.name

        resultText = """
        \(team1.name) (\(p1.name)) chose \(c1.rawValue).
        \(team2.name) (\(p2.name)) chose \(c2.rawValue).

        \(winnerTeamName) - goes first!
        """

        applyRPSResult(
            result: team1Wins ? .team1Win : .team2Win,
            player1: p1,
            player2: p2
        )
    }

    private enum RPSResult {
        case team1Win
        case team2Win
        case tie
    }

    private func applyRPSResult(
        result: RPSResult,
        player1: PlayerEntity,
        player2: PlayerEntity
    ) {
        switch result {
        case .tie:
            player1.rpsTies += 1
            player2.rpsTies += 1

        case .team1Win:
            player1.rpsWins += 1
            player2.rpsLosses += 1

        case .team2Win:
            player1.rpsLosses += 1
            player2.rpsWins += 1
        }

        do {
            try modelContext.save()
        } catch {
            // You can surface this as an alert later if you want
            print("⚠️ Failed to save RPS stats: \(error)")
        }
    }
}
