import SwiftUI

struct BeerPongTableView: View {
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

    var body: some View {
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
        .onChange(of: leftSideScore) { _, newValue in
            game = game.update(team1CupsSunk: newValue)
        }
        .onChange(of: rightSideScore) { _, newValue in
            game = game.update(team2CupsSunk: newValue)
        }
    }
}
