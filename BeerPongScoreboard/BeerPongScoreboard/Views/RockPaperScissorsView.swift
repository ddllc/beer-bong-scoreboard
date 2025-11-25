import SwiftUI
import SwiftData

struct RockPaperScissorsView: View {
    let team1: TeamEntity
    let team2: TeamEntity

    @Environment(\.dismiss) private var dismiss

    private enum RPSChoice: String, CaseIterable {
        case rock = "Rock"
        case paper = "Paper"
        case scissors = "Scissors"
    }

    @State private var team1Choice: RPSChoice?
    @State private var team2Choice: RPSChoice?
    @State private var resultText: String = "Pick Rock, Paper, or Scissors for each team."

    var body: some View {
        VStack(spacing: 24) {
            Text("Rock • Paper • Scissors")
                .font(.largeTitle.bold())

            // Team 1 section
            VStack(spacing: 8) {
                Text(team1.name)
                    .font(.title3.bold())

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

            // Team 2 section
            VStack(spacing: 8) {
                Text(team2.name)
                    .font(.title3.bold())

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

            // Result
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
        guard let c1 = team1Choice, let c2 = team2Choice else {
            resultText = "Both teams pick Rock, Paper, or Scissors."
            return
        }

        if c1 == c2 {
            resultText = """
            \(team1.name) chose \(c1.rawValue).
            \(team2.name) chose \(c2.rawValue).

            It's a tie! Change a choice to play again.
            """
            return
        }

        let team1Wins =
            (c1 == .rock && c2 == .scissors) ||
            (c1 == .paper && c2 == .rock) ||
            (c1 == .scissors && c2 == .paper)

        let winnerName = team1Wins ? team1.name : team2.name

        resultText = """
        \(team1.name) chose \(c1.rawValue).
        \(team2.name) chose \(c2.rawValue).

        \(winnerName) goes first!
        """
    }
}
