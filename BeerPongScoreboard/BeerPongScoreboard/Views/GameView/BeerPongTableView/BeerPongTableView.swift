import SwiftUI

struct BeerPongTableView: View {
    @Environment(AppData.self) private var appData
    @Binding var game: GameModel
    @Binding var isActionsModalPresented: Bool
    let cupSize: CGFloat = 60

    @State private var leftSideScore = 0
    @State private var rightSideScore = 0

    @State private var isLeftCup1SunkAnimationActive = false
    @State private var isLeftCup2SunkAnimationActive = false
    @State private var isLeftCup3SunkAnimationActive = false
    @State private var isLeftCup4SunkAnimationActive = false
    @State private var isLeftCup5SunkAnimationActive = false
    @State private var isLeftCup6SunkAnimationActive = false
    @State private var isLeftCup7SunkAnimationActive = false
    @State private var isLeftCup8SunkAnimationActive = false
    @State private var isLeftCup9SunkAnimationActive = false
    @State private var isLeftCup10SunkAnimationActive = false
    @State private var isRerackAt6CupAvailable = false

    @State private var isRightCup1SunkAnimationActive = false
    @State private var isRightCup2SunkAnimationActive = false
    @State private var isRightCup3SunkAnimationActive = false
    @State private var isRightCup4SunkAnimationActive = false
    @State private var isRightCup5SunkAnimationActive = false
    @State private var isRightCup6SunkAnimationActive = false
    @State private var isRightCup7SunkAnimationActive = false
    @State private var isRightCup8SunkAnimationActive = false
    @State private var isRightCup9SunkAnimationActive = false
    @State private var isRightCup10SunkAnimationActive = false

    private var leftRemainingCupIDs: [Int] {
        [
            (1, isLeftCup1SunkAnimationActive),
            (2, isLeftCup2SunkAnimationActive),
            (3, isLeftCup3SunkAnimationActive),
            (4, isLeftCup4SunkAnimationActive),
            (5, isLeftCup5SunkAnimationActive),
            (6, isLeftCup6SunkAnimationActive),
            (7, isLeftCup7SunkAnimationActive),
            (8, isLeftCup8SunkAnimationActive),
            (9, isLeftCup9SunkAnimationActive),
            (10, isLeftCup10SunkAnimationActive)
        ]
            .filter { !$0.1 }
            .map { $0.0 }
    }

    private var rightRemainingCupIDs: [Int] {
        [
            (1, isRightCup1SunkAnimationActive),
            (2, isRightCup2SunkAnimationActive),
            (3, isRightCup3SunkAnimationActive),
            (4, isRightCup4SunkAnimationActive),
            (5, isRightCup5SunkAnimationActive),
            (6, isRightCup6SunkAnimationActive),
            (7, isRightCup7SunkAnimationActive),
            (8, isRightCup8SunkAnimationActive),
            (9, isRightCup9SunkAnimationActive),
            (10, isRightCup10SunkAnimationActive)
        ]
            .filter { !$0.1 }
            .map { $0.0 }
    }

    // MARK: - ID → Binding (LEFT)

    private func leftCupBinding(id: Int) -> Binding<Bool> {
        switch id {
        case 1: return $isLeftCup1SunkAnimationActive
        case 2: return $isLeftCup2SunkAnimationActive
        case 3: return $isLeftCup3SunkAnimationActive
        case 4: return $isLeftCup4SunkAnimationActive
        case 5: return $isLeftCup5SunkAnimationActive
        case 6: return $isLeftCup6SunkAnimationActive
        case 7: return $isLeftCup7SunkAnimationActive
        case 8: return $isLeftCup8SunkAnimationActive
        case 9: return $isLeftCup9SunkAnimationActive
        default: return $isLeftCup10SunkAnimationActive
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                // MARK: - Team 1
                VStack(spacing: 4) {
                    Text(game.team1.name.uppercased())
                        .font(.headline)
                        .lineLimit(1)


                    HStack(spacing: 3) {
                        ForEach(1...10, id: \.self) { index in
                            Image(systemName: index <= game.team1CupsSunk ? "circle.fill" : "circle")
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
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
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "arrow.right")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 2)
                        .padding(.trailing, 4)
                }
                .onTapGesture {
                    guard appData.isTurnIndicatorEnabled else { return }
                    if appData.currentTurnTeamID == game.team1.id {
                        appData.currentTurnTeamID = nil
                    } else {
                        appData.currentTurnTeamID = game.team1.id
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
                        withAnimation {
                            isActionsModalPresented.toggle()
                        }
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

                    HStack(spacing: 3) {
                        ForEach(1...10, id: \.self) { index in
                            Image(systemName: index <= game.team2CupsSunk ? "circle.fill" : "circle")
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
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
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .overlay(alignment: .topLeading) {
                    Image(systemName: "arrow.left")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 2)
                        .padding(.leading, 4)
                }
                .onTapGesture {
                    guard appData.isTurnIndicatorEnabled else { return }
                    if appData.currentTurnTeamID == game.team2.id {
                        appData.currentTurnTeamID = nil
                    } else {
                        appData.currentTurnTeamID = game.team2.id
                    }
                }
            }
            .padding(.vertical, 4)

            ZStack {
                Color("TableBackground")

                // MARK: - CENTER DIVIDER LINE
                Rectangle()
                    .fill(.white)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                HStack {
                    // MARK: - LEFT RACK (BLUE TEAM) 10 Cup Rack
                    HStack(spacing: isActionsModalPresented ? 0 : 26) {
                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup1SunkAnimationActive)
                                .onChange(of: isLeftCup1SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup2SunkAnimationActive)
                                .onChange(of: isLeftCup2SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup3SunkAnimationActive)
                                .onChange(of: isLeftCup3SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup4SunkAnimationActive)
                                .onChange(of: isLeftCup4SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup5SunkAnimationActive)
                                .onChange(of: isLeftCup5SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup6SunkAnimationActive)
                                .onChange(of: isLeftCup6SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup7SunkAnimationActive)
                                .onChange(of: isLeftCup7SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup8SunkAnimationActive)
                                .onChange(of: isLeftCup8SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup9SunkAnimationActive)
                                .onChange(of: isLeftCup9SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup10SunkAnimationActive)
                                .onChange(of: isLeftCup10SunkAnimationActive) { _, newValue in
                                    leftSideScore += newValue ? 1 : -1
                                }
                        }
                    }

                    Spacer()

                    // MARK: - RIGHT RACK (RED TEAM) 10 Cup Rack
                    HStack(spacing: isActionsModalPresented ? 0 : 26) {
                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup1SunkAnimationActive)
                                .onChange(of: isRightCup1SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup2SunkAnimationActive)
                                .onChange(of: isRightCup2SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup3SunkAnimationActive)
                                .onChange(of: isRightCup3SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup4SunkAnimationActive)
                                .onChange(of: isRightCup4SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup5SunkAnimationActive)
                                .onChange(of: isRightCup5SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup6SunkAnimationActive)
                                .onChange(of: isRightCup6SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }
                        }

                        VStack(spacing: isActionsModalPresented ? 0 : 20) {

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup7SunkAnimationActive)
                                .onChange(of: isRightCup7SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup8SunkAnimationActive)
                                .onChange(of: isRightCup8SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup9SunkAnimationActive)
                                .onChange(of: isRightCup9SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }

                            SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup10SunkAnimationActive)
                                .onChange(of: isRightCup10SunkAnimationActive) { _, newValue in
                                    rightSideScore += newValue ? 1 : -1
                                }
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }

        .onChange(of: leftSideScore) { _, newValue in
            game = game.update(team1CupsSunk: newValue)
        }
        .onChange(of: rightSideScore) { _, newValue in
            game = game.update(team2CupsSunk: newValue)
        }
        .onChange(of: leftRemainingCupIDs) { _, newValue in
            print("🟦 LEFT RACK UPDATED → Remaining cups:", newValue)

        }
        .onChange(of: rightRemainingCupIDs) { _, newValue in
            print("🟥 RIGHT RACK UPDATED → Remaining cups:", newValue)
        }
    }
}
