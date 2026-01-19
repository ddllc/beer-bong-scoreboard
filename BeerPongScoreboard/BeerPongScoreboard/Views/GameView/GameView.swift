import SwiftUI

struct GameView: View {
    @Binding var navigationPath: NavigationPath
    // MARK: - Environment Objects
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss

    // MARK: - GameModel & CupSize
    @State private var game: GameModel
    let cupSize: CGFloat = 60

    // MARK: - Modal States
    @State private var isWinnerSheetPresented = false
    @State private var isActionsModalPresented = false

    // MARK: - Pause Duration State
    @State private var isGamePaused = false
    @State private var accumulatedPausedSeconds: TimeInterval = 0
    @State private var pausedAt: Date? = nil

    private var effectiveStartDateForTimer: Date {
        game.startedAt.addingTimeInterval(accumulatedPausedSeconds)
    }

    private var timerEndDateForDisplay: Date {
        if isGamePaused, let pausedAt { return pausedAt }
        return Date()
    }

    private func togglePause() {
        if isGamePaused {
            if let pausedAt {
                accumulatedPausedSeconds += Date().timeIntervalSince(pausedAt)
            }
            self.pausedAt = nil
            isGamePaused = false
        } else {
            pausedAt = Date()
            isGamePaused = true
        }
    }

    // MARK: - Winner Confirmation Alert
    private enum FinalCupSide {
        case left
        case right
    }

    private struct PendingFinalCup: Identifiable {
        let id = UUID()
        let side: FinalCupSide
        let cupID: Int
    }

    @State private var isDeclareWinnerAlertPresented = false
    @State private var pendingFinalCup: PendingFinalCup? = nil

    private func confirmDeclareWinner() {
        guard let pendingFinalCup else { return }

        // Actually sink the final cup now (this will flow into your existing onChange winner logic)
        switch pendingFinalCup.side {
        case .left:
            left10CupBinding(id: pendingFinalCup.cupID).wrappedValue = true
        case .right:
            right10CupBinding(id: pendingFinalCup.cupID).wrappedValue = true
        }

        self.pendingFinalCup = nil
        isDeclareWinnerAlertPresented = false
    }

    private func cancelDeclareWinner() {
        pendingFinalCup = nil
        isDeclareWinnerAlertPresented = false
    }

    // MARK: - Left Cup Animations
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

    // MARK: - Right Cup Animations
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

    // MARK: Rerack States
    @State private var isChoosingRerack10Left = true
    @State private var isChoosingRerack10Right = true
    @State private var isChoosingRerack6Left = false
    @State private var isChoosingRerack6Right = false
    @State private var isChoosingRerack4Left = false
    @State private var isChoosingRerack4Right = false
    @State private var isChoosingRerack3Left = false
    @State private var isChoosingRerack3Right = false
    @State private var leftReracksUsed = 0
    @State private var rightReracksUsed = 0

    // MARK: Team Scores
    private var leftSideScore: Int {
        [isLeftCup1SunkAnimationActive, isLeftCup2SunkAnimationActive, isLeftCup3SunkAnimationActive, isLeftCup4SunkAnimationActive, isLeftCup5SunkAnimationActive,
         isLeftCup6SunkAnimationActive, isLeftCup7SunkAnimationActive, isLeftCup8SunkAnimationActive, isLeftCup9SunkAnimationActive, isLeftCup10SunkAnimationActive]
            .filter { $0 }
            .count
    }

    private var rightSideScore: Int {
        [isRightCup1SunkAnimationActive, isRightCup2SunkAnimationActive, isRightCup3SunkAnimationActive, isRightCup4SunkAnimationActive, isRightCup5SunkAnimationActive,
         isRightCup6SunkAnimationActive, isRightCup7SunkAnimationActive, isRightCup8SunkAnimationActive, isRightCup9SunkAnimationActive, isRightCup10SunkAnimationActive]
            .filter { $0 }
            .count
    }

    // MARK: -  10 Remaining Cups
    private var leftRemaining10CupIDs: [Int] {
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
        .sorted()
    }

    private var rightRemaining10CupIDs: [Int] {
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
        .sorted()
    }

    private func left10CupBinding(id: Int) -> Binding<Bool> {
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

    private func right10CupBinding(id: Int) -> Binding<Bool> {
        switch id {
        case 1: return $isRightCup1SunkAnimationActive
        case 2: return $isRightCup2SunkAnimationActive
        case 3: return $isRightCup3SunkAnimationActive
        case 4: return $isRightCup4SunkAnimationActive
        case 5: return $isRightCup5SunkAnimationActive
        case 6: return $isRightCup6SunkAnimationActive
        case 7: return $isRightCup7SunkAnimationActive
        case 8: return $isRightCup8SunkAnimationActive
        case 9: return $isRightCup9SunkAnimationActive
        default: return $isRightCup10SunkAnimationActive
        }
    }

    // MARK: - Cup bindings that intercept the final cup
    private func leftCupBindingWithWinnerCheck(id: Int) -> Binding<Bool> {
        let base = left10CupBinding(id: id)
        return Binding(
            get: { base.wrappedValue },
            set: { newValue in
                // Only intercept "false -> true" (a newly sunk cup)
                if newValue == true, base.wrappedValue == false {
                    let willBe = leftSideScore + 1
                    if willBe == 10, game.winnerTeamID == nil {
                        pendingFinalCup = PendingFinalCup(side: .left, cupID: id)
                        isDeclareWinnerAlertPresented = true
                        return // do NOT sink it yet
                    }
                }
                base.wrappedValue = newValue
            }
        )
    }

    private func rightCupBindingWithWinnerCheck(id: Int) -> Binding<Bool> {
        let base = right10CupBinding(id: id)
        return Binding(
            get: { base.wrappedValue },
            set: { newValue in
                if newValue == true, base.wrappedValue == false {
                    let willBe = rightSideScore + 1
                    if willBe == 10, game.winnerTeamID == nil {
                        pendingFinalCup = PendingFinalCup(side: .right, cupID: id)
                        isDeclareWinnerAlertPresented = true
                        return
                    }
                }
                base.wrappedValue = newValue
            }
        )
    }

    // MARK: - 6 Remaining Cups
    private let leftRerack6CupPositions: [Int] = [1, 2, 3, 4, 5, 6]
    private var leftRemaining6CupIDs: [Int] {
        leftRerack6CupPositions
            .filter { id in !left10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    private let rightRerack6CupPositions: [Int] = [1, 2, 3, 4, 5, 6]
    private var rightRemaining6CupIDs: [Int] {
        rightRerack6CupPositions
            .filter { id in !right10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    // MARK: - 4 Remaining Cups
    private let leftRerack4CupPositions: [Int] = [1, 2, 3, 4]
    private var leftRemaining4CupIDs: [Int] {
        leftRerack4CupPositions
            .filter { id in !left10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    private let rightRerack4CupPositions: [Int] = [1, 2, 3, 4]
    private var rightRemaining4CupIDs: [Int] {
        rightRerack4CupPositions
            .filter { id in !right10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    // MARK: - 3 Remaining Cups
    private let leftRerack3CupPositions: [Int] = [1, 2, 3]
    private var leftRemaining3CupIDs: [Int] {
        leftRerack3CupPositions
            .filter { id in !left10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    private let rightRerack3CupPositions: [Int] = [1, 2, 3]
    private var rightRemaining3CupIDs: [Int] {
        rightRerack3CupPositions
            .filter { id in !right10CupBinding(id: id).wrappedValue }
            .sorted()
    }

    // ✅ Active remaining count (THIS is what makes the buttons work across 10/6/4/3 modes)
    private var leftActiveRemainingCount: Int {
        if isChoosingRerack10Left { return leftRemaining10CupIDs.count }
        else if isChoosingRerack6Left { return leftRemaining6CupIDs.count }
        else if isChoosingRerack4Left { return leftRemaining4CupIDs.count }
        else if isChoosingRerack3Left { return leftRemaining3CupIDs.count }
        else { return leftRemaining10CupIDs.count }
    }

    private var rightActiveRemainingCount: Int {
        if isChoosingRerack10Right { return rightRemaining10CupIDs.count }
        else if isChoosingRerack6Right { return rightRemaining6CupIDs.count }
        else if isChoosingRerack4Right { return rightRemaining4CupIDs.count }
        else if isChoosingRerack3Right { return rightRemaining3CupIDs.count }
        else { return rightRemaining10CupIDs.count }
    }

    // MARK: Rerack availability (now uses active remaining count)
    private var rerackAt6AvailableForLeft: Bool { appData.isRerackEnabled && leftActiveRemainingCount == 6 && !isChoosingRerack6Left }
    private var rerackAt4AvailableForLeft: Bool { appData.isRerackEnabled && leftActiveRemainingCount == 4 && !isChoosingRerack4Left }
    private var rerackAt3AvailableForLeft: Bool { appData.isRerackEnabled && leftActiveRemainingCount == 3 && !isChoosingRerack3Left }

    private var rerackAt6AvailableForRight: Bool { appData.isRerackEnabled && rightActiveRemainingCount == 6 && !isChoosingRerack6Right }
    private var rerackAt4AvailableForRight: Bool { appData.isRerackEnabled && rightActiveRemainingCount == 4 && !isChoosingRerack4Left }
    private var rerackAt3AvailableForRight: Bool { appData.isRerackEnabled && rightActiveRemainingCount == 3 && !isChoosingRerack3Right }

    // MARK: - Reset Helpers
    private func resetLeftSide(clearReracksUsed: Bool = true) {
        isLeftCup1SunkAnimationActive = false
        isLeftCup2SunkAnimationActive = false
        isLeftCup3SunkAnimationActive = false
        isLeftCup4SunkAnimationActive = false
        isLeftCup5SunkAnimationActive = false
        isLeftCup6SunkAnimationActive = false
        isLeftCup7SunkAnimationActive = false
        isLeftCup8SunkAnimationActive = false
        isLeftCup9SunkAnimationActive = false
        isLeftCup10SunkAnimationActive = false

        isChoosingRerack10Left = true
        isChoosingRerack6Left = false
        isChoosingRerack4Left = false
        isChoosingRerack3Left = false

        if clearReracksUsed { leftReracksUsed = 0 }
    }

    private func resetRightSide(clearReracksUsed: Bool = true) {
        isRightCup1SunkAnimationActive = false
        isRightCup2SunkAnimationActive = false
        isRightCup3SunkAnimationActive = false
        isRightCup4SunkAnimationActive = false
        isRightCup5SunkAnimationActive = false
        isRightCup6SunkAnimationActive = false
        isRightCup7SunkAnimationActive = false
        isRightCup8SunkAnimationActive = false
        isRightCup9SunkAnimationActive = false
        isRightCup10SunkAnimationActive = false

        isChoosingRerack10Right = true
        isChoosingRerack6Right = false
        isChoosingRerack4Right = false
        isChoosingRerack3Right = false

        if clearReracksUsed { rightReracksUsed = 0 }
    }

    // MARK: Init
    init(navigationPath: Binding<NavigationPath>, game: GameModel) {
        self._navigationPath = navigationPath
        _game = State(initialValue: game)
    }

    // MARK: Body
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack(alignment: .bottom) {
                        // MARK: - Left Scoreboard
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

                        // MARK: - Middle Scoreboard
                        VStack(spacing: 0) {
                            Spacer()

                            Text("\(game.team1CupsSunk) - \(game.team2CupsSunk)")
                                .font(.title)
                                .fontWeight(.heavy)
                                .monospacedDigit()

                            HStack(spacing: 6) {
                                Text("Duration")

                                TimelineView(.periodic(from: Date(), by: 1)) { _ in
                                    Text(timerInterval: effectiveStartDateForTimer ... timerEndDateForDisplay, countsDown: false)
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
                                Image(systemName: isActionsModalPresented ? "chevron.compact.down" : "chevron.compact.up")
                                    .font(.title3)
                            }
                        }

                        Spacer()

                        // MARK: - Right Scoreboard
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
                        // ✅ RIGHT SIDE NOW MATCHES LEFT: 6, then 4, then 3
                        .overlay {
                            if rerackAt6AvailableForRight {
                                Button("Rerack 6") {
                                    applyRerack6Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = true
                                    isChoosingRerack4Right = false
                                    isChoosingRerack3Right = false
                                    rightReracksUsed += 1
                                }
                            } else if rerackAt4AvailableForRight {
                                Button("Rerack 4") {
                                    applyRerack4Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = false
                                    isChoosingRerack4Right = true
                                    isChoosingRerack3Right = false
                                    rightReracksUsed += 1
                                }
                            } else if rerackAt3AvailableForRight {
                                Button("Rerack 3") {
                                    applyRerack3Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = false
                                    isChoosingRerack4Right = false
                                    isChoosingRerack3Right = true
                                    rightReracksUsed += 1
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)

                    ZStack {
                        // MARK: - Table Background
                        Color("TableBackground")

                        // MARK: - CENTER DIVIDER LINE
                        Rectangle()
                            .fill(.white)
                            .frame(width: 2)
                            .frame(maxHeight: .infinity)

                        HStack {
                            // MARK: - LEFT 10 CUP RACK
                            if isChoosingRerack10Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 1))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 3))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 4))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 5))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 6))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 7))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 8))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 9))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 10))
                                    }
                                }
                            } else if isChoosingRerack6Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 1))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 3))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 4))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 5))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 6))
                                    }
                                }
                            } else if isChoosingRerack4Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 1))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 3))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 4))
                                    }
                                }
                            } else if isChoosingRerack3Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 1))
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 2))
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: leftCupBindingWithWinnerCheck(id: 3))
                                    }
                                }
                            }

                            Spacer()

                            // MARK: - RIGHT 10 CUP RACK
                            if isChoosingRerack10Right {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 1))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 3))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 4))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 5))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 6))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 7))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 8))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 9))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 10))
                                    }
                                }
                            } else if isChoosingRerack6Right {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 1))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 3))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 4))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 5))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 6))
                                    }
                                }
                            } else if isChoosingRerack4Right {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 1))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 2))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 3))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 4))
                                    }
                                }
                            } else if isChoosingRerack3Right {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 1))
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 2))
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: rightCupBindingWithWinnerCheck(id: 3))
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: cupSize * 4 + 40)
                    .overlay(alignment: .top) {
                        VStack {
                            if rerackAt6AvailableForLeft {
                                Button("Rerack 6") {
                                    applyRerack6Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = true
                                    isChoosingRerack4Left = false
                                    isChoosingRerack3Left = false
                                    leftReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))
                            } else if rerackAt4AvailableForLeft {
                                Button("Rerack 4") {
                                    applyRerack4Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = false
                                    isChoosingRerack4Left = true
                                    isChoosingRerack3Left = false
                                    leftReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))
                            } else if rerackAt3AvailableForLeft {
                                Button("Rerack 3") {
                                    applyRerack3Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = false
                                    isChoosingRerack4Left = false
                                    isChoosingRerack3Left = true
                                    leftReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))
                            }
                        }
                        .padding(.trailing, 125)
                        .padding(.top)
                    }
                    .overlay(alignment: .top) {
                        VStack {
                            if rerackAt6AvailableForRight {
                                Button("Rerack 6") {
                                    applyRerack6Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = true
                                    isChoosingRerack4Right = false
                                    isChoosingRerack3Right = false
                                    rightReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))

                            } else if rerackAt4AvailableForRight {
                                Button("Rerack 4") {
                                    applyRerack4Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = false
                                    isChoosingRerack4Right = true
                                    isChoosingRerack3Right = false
                                    rightReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))

                            } else if rerackAt3AvailableForRight {
                                Button("Rerack 3") {
                                    applyRerack3Right()
                                    isChoosingRerack10Right = false
                                    isChoosingRerack6Right = false
                                    isChoosingRerack4Right = false
                                    isChoosingRerack3Right = true
                                    rightReracksUsed += 1
                                }
                                .buttonStyle(.glass)
                                .buttonSizing(.fitted)
                                .buttonBorderShape(.roundedRectangle(radius: 8))
                            }
                        }
                        .padding(.leading, 125)
                        .padding(.top)
                    }
                }
                .onChange(of: leftSideScore) { _, newValue in
                    game = game.update(team1CupsSunk: newValue)
                }
                .onChange(of: rightSideScore) { _, newValue in
                    game = game.update(team2CupsSunk: newValue)
                }
            }

            // MARK: - Menu Modal
            if isActionsModalPresented {
                ZStack {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isActionsModalPresented = false }
                        }

                    VStack(spacing: 16) {
                        Button(isGamePaused ? "Resume Game" : "Pause Game") {
                            togglePause()
                        }
                        .buttonStyle(.glassProminent)
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        .frame(width: 200)

                        Button("Cancel Game", role: .cancel) {
                            dismiss()
                        }
                        .buttonStyle(.glassProminent)
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        .frame(width: 200)

                        HStack {
                            Button("Reset Left") { withAnimation { resetLeftSide() } }
                                .buttonStyle(.glass)
                                .buttonBorderShape(.roundedRectangle(radius: 8))

                            Button("Reset Right") { withAnimation { resetRightSide() } }
                                .buttonStyle(.glass)
                                .buttonBorderShape(.roundedRectangle(radius: 8))
                        }
                        .padding(.top, 4)

                        Button("Close Menu") {
                            withAnimation { isActionsModalPresented = false }
                        }
                        .buttonStyle(.glass)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .contentShape(Rectangle())
                    .onTapGesture { }
                }
                .transition(.opacity)
            }
        }
        .navigationBarBackButtonHidden(true)

        // ✅ Winner confirmation alert (fires BEFORE the last cup actually sinks)
        .alert("Declare Winner?", isPresented: $isDeclareWinnerAlertPresented) {
            Button("Cancel", role: .cancel) { cancelDeclareWinner() }
            Button("OK") { confirmDeclareWinner() }
        } message: {
            Text("Are you sure you would like to declare a winner?")
        }

        .onChange(of: game.team1CupsSunk) { _, newValue in
            guard newValue == 10, game.winnerTeamID == nil else { return }

            let updatedTeam1 = game.team1.update(wins: game.team1.wins + 1)
            let updatedTeam2 = game.team2.update(losses: game.team2.losses + 1)

            game = game.update(
                endedAt: Date(),
                team1: updatedTeam1,
                team2: updatedTeam2,
                winnerTeamID: game.team1.id
            )

            isWinnerSheetPresented = true
        }

        .onChange(of: game.team2CupsSunk) { _, newValue in
            guard newValue == 10, game.winnerTeamID == nil else { return }

            let updatedTeam2 = game.team2.update(wins: game.team2.wins + 1)
            let updatedTeam1 = game.team1.update(losses: game.team1.losses + 1)

            game = game.update(
                endedAt: Date(),
                team1: updatedTeam1,
                team2: updatedTeam2,
                winnerTeamID: game.team2.id
            )

            isWinnerSheetPresented = true
        }

        .sheet(isPresented: $isWinnerSheetPresented) {
            WinnerSheetView(navigationPath: $navigationPath, game: game)
        }
    }

    // MARK: - Rerack Methods (LEFT)
    private func applyLeftRerack(positions: [Int]) {
        isLeftCup1SunkAnimationActive = true
        isLeftCup2SunkAnimationActive = true
        isLeftCup3SunkAnimationActive = true
        isLeftCup4SunkAnimationActive = true
        isLeftCup5SunkAnimationActive = true
        isLeftCup6SunkAnimationActive = true
        isLeftCup7SunkAnimationActive = true
        isLeftCup8SunkAnimationActive = true
        isLeftCup9SunkAnimationActive = true
        isLeftCup10SunkAnimationActive = true

        for id in positions {
            switch id {
            case 1: isLeftCup1SunkAnimationActive = false
            case 2: isLeftCup2SunkAnimationActive = false
            case 3: isLeftCup3SunkAnimationActive = false
            case 4: isLeftCup4SunkAnimationActive = false
            case 5: isLeftCup5SunkAnimationActive = false
            case 6: isLeftCup6SunkAnimationActive = false
            case 7: isLeftCup7SunkAnimationActive = false
            case 8: isLeftCup8SunkAnimationActive = false
            case 9: isLeftCup9SunkAnimationActive = false
            default: isLeftCup10SunkAnimationActive = false
            }
        }
    }

    private func applyRerack6Left() {
        let rerackPositions: [Int] = [1, 2, 3, 4, 5, 6]
        applyLeftRerack(positions: rerackPositions)
    }

    private func applyRerack4Left() {
        let rerackPositions: [Int] = [1, 2, 3, 4]
        applyLeftRerack(positions: rerackPositions)
    }

    private func applyRerack3Left() {
        let rerackPositions: [Int] = [1, 2, 3]
        applyLeftRerack(positions: rerackPositions)
    }

    // MARK: - Rerack Methods (RIGHT)
    private func applyRightRerack(positions: [Int]) {
        isRightCup1SunkAnimationActive = true
        isRightCup2SunkAnimationActive = true
        isRightCup3SunkAnimationActive = true
        isRightCup4SunkAnimationActive = true
        isRightCup5SunkAnimationActive = true
        isRightCup6SunkAnimationActive = true
        isRightCup7SunkAnimationActive = true
        isRightCup8SunkAnimationActive = true
        isRightCup9SunkAnimationActive = true
        isRightCup10SunkAnimationActive = true

        for id in positions {
            switch id {
            case 1: isRightCup1SunkAnimationActive = false
            case 2: isRightCup2SunkAnimationActive = false
            case 3: isRightCup3SunkAnimationActive = false
            case 4: isRightCup4SunkAnimationActive = false
            case 5: isRightCup5SunkAnimationActive = false
            case 6: isRightCup6SunkAnimationActive = false
            case 7: isRightCup7SunkAnimationActive = false
            case 8: isRightCup8SunkAnimationActive = false
            case 9: isRightCup9SunkAnimationActive = false
            default: isRightCup10SunkAnimationActive = false
            }
        }
    }

    private func applyRerack6Right() {
        let rerackPositions: [Int] = [1, 2, 3, 4, 5, 6]
        applyRightRerack(positions: rerackPositions)
    }

    private func applyRerack4Right() {
        let rerackPositions: [Int] = [1, 2, 3, 4]
        applyRightRerack(positions: rerackPositions)
    }

    private func applyRerack3Right() {
        let rerackPositions: [Int] = [1, 2, 3]
        applyRightRerack(positions: rerackPositions)
    }
}
