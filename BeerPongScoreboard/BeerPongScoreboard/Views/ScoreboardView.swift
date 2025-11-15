import SwiftUI

struct GameRecord: Identifiable, Hashable {
    let id = UUID()
    let winnerName: String
    let turnsToWin: Int
    let date: Date
}

struct ScoreboardView: View {
    @Binding var records: [GameRecord]
    var playerOneName: String?
    var playerTwoName: String?

    var body: some View {
        Group {
            if records.isEmpty {
                ContentUnavailableView("No Games Yet", systemImage: "trophy", description: Text("Play a game to see results here."))
            } else {
                List(records.sorted(by: { $0.date > $1.date })) { record in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(record.winnerName)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "trophy.fill").foregroundStyle(.yellow)
                        }
                        Text("Turns to win: \(record.turnsToWin)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(record.date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Scoreboard")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Clear") { records.removeAll() }
                    .disabled(records.isEmpty)
            }
        }
    }
}

#Preview {
    @State var sample: [GameRecord] = [
        GameRecord(winnerName: "Alex", turnsToWin: 7, date: .now),
        GameRecord(winnerName: "Blake", turnsToWin: 9, date: .now.addingTimeInterval(-3600))
    ]
    return NavigationStack { ScoreboardView(records: $sample, playerOneName: "Alex", playerTwoName: "Blake") }
}
