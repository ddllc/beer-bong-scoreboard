import SwiftUI

struct ScoreboardView: View {
    @Environment(AppData.self) private var appData
    @Binding var game: GameModel
    @Binding var isActionsModalPresented: Bool

    var body: some View {
        HStack(alignment: .bottom) {

            // MARK: - Team 1
            VStack(spacing: 4) {
                Text(game.team1.name.uppercased())
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .foregroundStyle(
                        appData.isTurnIndicatorEnabled && appData.currentTurnTeamID == game.team1.id
                        ? Color.white
                        : Color.primary
                    )
                    .background(
                        appData.isTurnIndicatorEnabled && appData.currentTurnTeamID == game.team1.id
                        ? Color("SoloCupBlue")
                        : Color.clear
                    )
                    .clipShape(Capsule())
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard appData.isTurnIndicatorEnabled else { return }
                        if appData.currentTurnTeamID == game.team1.id {
                            appData.currentTurnTeamID = nil
                        } else {
                            appData.currentTurnTeamID = game.team1.id
                        }
                    }

                HStack(spacing: 3) {
                    ForEach(1...10, id: \.self) { index in
                        Image(systemName: index <= game.team1CupsSunk ? "circle.fill" : "circle")
                    }
                }
            }

            Spacer()

            // MARK: - Score + Timer
            VStack(spacing: 0) {
                Spacer()

                    Text("\(game.team1CupsSunk) - \(game.team2CupsSunk)")
                        .font(.title)
                        .fontWeight(.heavy)
                        .monospacedDigit()


                HStack(spacing: 6) {
                    Text("Duration")

                    TimelineView(.periodic(from: game.startedAt, by: 1)) { context in
                        Text(timerInterval: game.startedAt ... context.date, countsDown: false)
                            .italic()
                            .monospacedDigit()
                            .font(.callout)
                    }
                }


                    Button {
                        isActionsModalPresented.toggle()
                    } label: {
                        // chevron alternate
                        Image(systemName: isActionsModalPresented ? "chevron.compact.down" : "chevron.compact.up")
                            .font(.title3)
                    }

            }

            Spacer()

            // MARK: - Team 2
            VStack(spacing: 4) {
                Text(game.team2.name.uppercased())
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .foregroundStyle(
                        appData.isTurnIndicatorEnabled && appData.currentTurnTeamID == game.team2.id
                        ? Color.white
                        : Color.primary
                    )
                    .background(
                        appData.isTurnIndicatorEnabled && appData.currentTurnTeamID == game.team2.id
                        ? Color("SoloCupRed")
                        : Color.clear
                    )
                    .clipShape(Capsule())
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard appData.isTurnIndicatorEnabled else { return }
                        if appData.currentTurnTeamID == game.team2.id {
                            appData.currentTurnTeamID = nil   // tap again = clear
                        } else {
                            appData.currentTurnTeamID = game.team2.id
                        }
                    }

                HStack(spacing: 3) {
                    ForEach(1...10, id: \.self) { index in
                        Image(systemName: index <= game.team2CupsSunk ? "circle.fill" : "circle")
                    }
                }
            }
        }
        .frame(height: 75)
        .padding(.horizontal)
        .ignoresSafeArea(edges: .top)
    }
}

