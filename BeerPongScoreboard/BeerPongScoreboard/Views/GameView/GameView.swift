import SwiftUI

struct GameView: View {
    // MARK: - Environment Objects
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss

    // MARK: - GameModel & CupSize
    @State private var game: GameModel
    let cupSize: CGFloat = 60

    // MARK: - Modal States
    @State private var isWinnerSheetPresented = false
    @State private var isActionsModalPresented = false

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

    private var rerackAt6AvailableForLeft: Bool {
        appData.isRerackEnabled && leftActiveRemainingCount == 6
    }

    private var rerackAt4AvailableForLeft: Bool {
        appData.isRerackEnabled && leftActiveRemainingCount == 4
    }

    private var rerackAt3AvailableForLeft: Bool {
        appData.isRerackEnabled && leftActiveRemainingCount == 3
    }

    private var rerackAt6AvailableForRight: Bool {
        appData.isRerackEnabled && rightActiveRemainingCount == 6
    }

    private var rerackAt4AvailableForRight: Bool {
        appData.isRerackEnabled && rightActiveRemainingCount == 4
    }

    private var rerackAt3AvailableForRight: Bool {
        appData.isRerackEnabled && rightActiveRemainingCount == 3
    }



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

    // MARK: - 6 Remaining Cups
    private let leftRerack6CupPositions: [Int] = [1, 2, 3, 4, 5, 6]

    private var leftRemaining6CupIDs: [Int] {
        leftRerack6CupPositions
            .filter { id in
                !left10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }

    private let rightRerack6CupPositions: [Int] = [1, 2, 3, 4, 5, 6]

    private var rightRemaining6CupIDs: [Int] {
        rightRerack6CupPositions
            .filter { id in
                !right10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }

    // MARK: - 4 Remaining Cups
    private let leftRerack4CupPositions: [Int] = [1, 2, 3, 4]

    private var leftRemaining4CupIDs: [Int] {
        leftRerack4CupPositions
            .filter { id in
                !left10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }

    private let rightRerack4CupPositions: [Int] = [1, 2, 3, 4]

    private var rightRemaining4CupIDs: [Int] {
        rightRerack4CupPositions
            .filter { id in
                !right10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }

    // MARK: - 3 Remaining Cups
    private let leftRerack3CupPositions: [Int] = [1, 2, 3]

    private var leftRemaining3CupIDs: [Int] {
        leftRerack3CupPositions
            .filter { id in
                !left10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }

    private let rightRerack3CupPositions: [Int] = [1, 2, 3]

    private var rightRemaining3CupIDs: [Int] {
        rightRerack3CupPositions
            .filter { id in
                !right10CupBinding(id: id).wrappedValue
            }
            .sorted()
    }


    // MARK: - Game Duration
    private var durationText: String {
        let end = game.endedAt ?? Date()
        let seconds = Int(end.timeIntervalSince(game.startedAt))

        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        return String(format: "%d:%02d", minutes, remainingSeconds)
    }

    // MARK: Init
    init(game: GameModel) {
        _game = State(initialValue: game)
    }

    // MARK: Body
    var body: some View {
        ZStack(alignment: .center) {
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
                        .overlay {
                            if rerackAt6AvailableForLeft {
                                Button("Rerack 6") {
                                    applyRerack6Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = true
                                    isChoosingRerack4Left = false
                                    isChoosingRerack3Left = false
                                    leftReracksUsed += 1
                                }
                            } else if rerackAt4AvailableForLeft {
                                Button("Rerack 4") {
                                    applyRerack4Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = false
                                    isChoosingRerack4Left = true
                                    isChoosingRerack3Left = false
                                    leftReracksUsed += 1
                                }
                            } else if rerackAt3AvailableForLeft {
                                Button("Rerack 3") {
                                    applyRerack3Left()
                                    isChoosingRerack10Left = false
                                    isChoosingRerack6Left = false
                                    isChoosingRerack4Left = false
                                    isChoosingRerack3Left = true
                                    leftReracksUsed += 1
                                }
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
                        .overlay {
                            if rerackAt6AvailableForRight {
                                Button("Rerack 6") {
                                    applyRerack6Right()
                                    isChoosingRerack6Right = true
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
                            // MARK: - LEFT 10 Cup Rack
                            if isChoosingRerack10Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup1SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup2SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup3SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup4SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup5SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup6SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup7SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup8SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup9SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup10SunkAnimationActive)
                                    }
                                }
                                .overlay(alignment: .topTrailing) {
                                    if rerackAt6AvailableForLeft {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundStyle(.yellow)
                                            .padding(.top, 2)
                                            .padding(.trailing, 4)

                                    }
                                }

                            } else if isChoosingRerack6Left {
                                // MARK: - LEFT 6 Cup Rack
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup1SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup2SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup3SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup4SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup5SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup6SunkAnimationActive)
                                    }
                                }
                            } else if isChoosingRerack4Left {
                                // MARK: - LEFT 4 Cup Rack
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup1SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup2SunkAnimationActive)
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup3SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup4SunkAnimationActive)
                                    }
                                }
                            } else if isChoosingRerack3Left {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup1SunkAnimationActive)

                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup2SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .blueWhiteRim, cupSize: cupSize, fallDirection: .left, isSunk: $isLeftCup3SunkAnimationActive)
                                    }
                                }

                            }

                            Spacer()

                            // MARK: - Right 10 Cup Rack
                            if isChoosingRerack10Right {
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup1SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup2SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup3SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup4SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup5SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup6SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup7SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup8SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup9SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup10SunkAnimationActive)
                                    }
                                }
                                .overlay(alignment: .topLeading) {
                                    if rerackAt6AvailableForRight {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundStyle(.yellow)
                                            .padding(.top, 2)
                                            .padding(.leading, 4)
                                    }
                                }

                            } else if isChoosingRerack6Right {
                                // MARK: - RIGHT 6 Cup Rack
                                HStack {
                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup1SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup2SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup3SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup4SunkAnimationActive)
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup5SunkAnimationActive)
                                    }

                                    VStack {
                                        SoloCupView(style: .redWhiteRim, cupSize: cupSize, fallDirection: .right, isSunk: $isRightCup6SunkAnimationActive)
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
                .onChange(of: leftRemaining10CupIDs) { _, newValue in
                    print("🟦 LEFT RACK UPDATED → Remaining cups:", newValue)
                }
                .onChange(of: rightRemaining10CupIDs) { _, newValue in
                    print("🟥 RIGHT RACK UPDATED → Remaining cups:", newValue)
                }
                .onChange(of: leftRemaining6CupIDs) { _, newValue in
                    print("🟦 LEFT 6 RERACK UPDATED → Remaining cups:", newValue)
                }
                .onChange(of: rightRemaining6CupIDs) { _, newValue in
                    print("🟦 RIGHT 6 RERACK UPDATED → Remaining cups:", newValue)
                }
            }


            // MARK: - Menu Modal
            VStack {
                Button("RERACK") {
                    dismiss()
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .frame(width: 200)

                Button("Pause Game") {
                    dismiss()
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .background(.secondary)
            .opacity(isActionsModalPresented ? 1 : 0)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: game.team1CupsSunk) { _, newValue in
            if newValue == 10 {
                game = game.update(endedAt: Date(), winnerTeamID: game.team1.id)
                isWinnerSheetPresented = true
            }
        }
        .onChange(of: game.team2CupsSunk) { _, newValue in
            if newValue == 10 {
                game = game.update(endedAt: Date(), winnerTeamID: game.team2.id)
                isWinnerSheetPresented = true
            }
        }
        .sheet(isPresented: $isWinnerSheetPresented) {
            WinnerSheetView(game: game)
        }
    }

    // MARK: - Rerack Methods
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
        // NOTE: survivors was unused; removed for now to avoid a warning.
        // Pick your 6-cup formation positions here.
        let rerackPositions: [Int] = [1, 2, 3, 4, 5, 6]
        applyLeftRerack(positions: rerackPositions)
    }

    private func applyRerack4Left() {
        // NOTE: survivors was unused; removed for now to avoid a warning.
        // Pick your 6-cup formation positions here.
        let rerackPositions: [Int] = [1, 2, 3, 4]
        applyLeftRerack(positions: rerackPositions)
    }

    private func applyRerack3Left() {
        // NOTE: survivors was unused; removed for now to avoid a warning.
        // Pick your 6-cup formation positions here.
        let rerackPositions: [Int] = [1, 2, 3]
        applyLeftRerack(positions: rerackPositions)
    }

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

}
