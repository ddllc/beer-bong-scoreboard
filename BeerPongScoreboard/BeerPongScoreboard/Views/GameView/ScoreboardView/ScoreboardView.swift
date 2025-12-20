import SwiftUI

struct ScoreboardView: View {
    @Binding var game: GameModel

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            // MARK: - Team 1
            VStack(spacing: 4) {
                Text("\(game.team1.name.uppercased())")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                Text("t1 cups: \(game.team1CupsSunk)")
                    .font(.caption)
                    .monospacedDigit()

                HStack(spacing: 3) {
                    ForEach(1...10, id: \.self) { index in
                        Image(systemName: index <= game.team1CupsSunk ? "circle.fill" : "circle")
                    }
                }
            }

            Spacer()

            VStack(spacing: 4) {
                HStack {
                    Text("\(game.team1.totalCupsSunk) - \(game.team2.totalCupsSunk)")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                HStack(spacing: 4) {
                    Text("Duration")
                    Text(timerInterval: .now ... Date(timeIntervalSinceNow: 86_400),countsDown: false)
                        .italic()
                        .monospacedDigit()
                        .font(.callout)
                }
            }

            Spacer()

            // MARK: - Team 2
            VStack(spacing: 4) {
                Text("\(game.team2.name.uppercased())")
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .font(.headline)

                HStack(spacing: 3) {
                    ForEach(1...10, id: \.self) { _ in
                        Image(systemName: "circle")
                            .font(.subheadline)
                    }
                }
            }
        }
        .frame(height: 75)
        .padding(.horizontal)
        .ignoresSafeArea(edges: .top)
        .onChange(of: game.team1CupsSunk) { oldValue, newValue in
            print("----------in scoreboard")
            print("old value: \(game.team1CupsSunk)")
            print("new Value: \(game.team1CupsSunk)")
            print("----------in scoreboard")
        }
    }
}
