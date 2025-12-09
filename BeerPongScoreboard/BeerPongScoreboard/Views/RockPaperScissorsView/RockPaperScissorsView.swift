import SwiftUI

private enum RPSChoice: String, CaseIterable, Identifiable {
    case rock
    case paper
    case scissors

    var id: String { rawValue }

    var label: String {
        switch self {
        case .rock:     return "🪨 Rock"
        case .paper:    return "📄 Paper"
        case .scissors: return "✂️ Scissors"
        }
    }
}

struct RockPaperScissorsView: View {
    let team1: TeamModel
    let team2: TeamModel

    /// Called when a winner is decided and the user confirms.
    /// Passes back the starting team.
    let onDecideStarter: (TeamModel) -> Void

    /// Called when the user cancels (optional).
    let onCancel: () -> Void

    @State private var team1Choice: RPSChoice?
    @State private var team2Choice: RPSChoice?
    @State private var resultText: String = "Both teams pick Rock, Paper, or Scissors."
    @State private var winningTeam: TeamModel?

    var body: some View {
        VStack(spacing: 24) {
            // Title
            Text("Who Goes First?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("Play Rock • Paper • Scissors to decide which team starts.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Team vs Team layout
            HStack(spacing: 16) {
                teamColumn(
                    title: team1.name,
                    choice: $team1Choice
                )

                Text("VS")
                    .font(.headline.bold())
                    .padding(.horizontal, 4)

                teamColumn(
                    title: team2.name,
                    choice: $team2Choice
                )
            }
            .padding(.horizontal)

            // Result text
            Text(resultText)
                .font(.body.weight(.medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            // Action buttons
            VStack(spacing: 12) {
                Button {
                    if let winner = winningTeam {
                        onDecideStarter(winner)
                    }
                } label: {
                    Text(startButtonTitle)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .font(.headline)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.borderedProminent)
                .disabled(winningTeam == nil)

                Button(role: .cancel) {
                    onCancel()
                } label: {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .padding(.top, 24)
        .onChange(of: team1Choice) {
            evaluateIfReady()
        }
        .onChange(of: team2Choice) {
            evaluateIfReady()
        }
    }

    // MARK: - Subviews

    private func teamColumn(
        title: String,
        choice: Binding<RPSChoice?>
    ) -> some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            // Choice buttons
            VStack(spacing: 8) {
                ForEach(RPSChoice.allCases) { option in
                    Button {
                        choice.wrappedValue = option
                    } label: {
                        HStack {
                            Text(option.label)
                            Spacer()
                            if choice.wrappedValue == option {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.medium)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                    .tint(choice.wrappedValue == option ? .accentColor : .secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Logic

    private var startButtonTitle: String {
        if let winner = winningTeam {
            return "\(winner.name) starts first"
        } else {
            return "Decide Starter"
        }
    }

    private func evaluateIfReady() {
        guard let t1 = team1Choice, let t2 = team2Choice else {
            winningTeam = nil
            resultText = "Both teams pick Rock, Paper, or Scissors."
            return
        }

        if t1 == t2 {
            winningTeam = nil
            resultText = "It's a tie! Pick again."
            return
        }

        let team1Wins = does(t1, beat: t2)

        if team1Wins {
            winningTeam = team1
            resultText = "\(team1.name) wins and goes first!"
        } else {
            winningTeam = team2
            resultText = "\(team2.name) wins and goes first!"
        }
    }

    private func does(_ a: RPSChoice, beat b: RPSChoice) -> Bool {
        switch (a, b) {
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
            return true
        default:
            return false
        }
    }
}


