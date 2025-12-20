import SwiftUI

struct BeerPongTableView: View {
    @Binding var game: GameModel
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
                .ignoresSafeArea(edges: [.leading, .trailing, .bottom])

            // MARK: - CENTER DIVIDER LINE
            Rectangle()
                .fill(.white)
                .frame(width: 2)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(edges: [.bottom])
            HStack {
                // MARK: - LEFT RACK (BLUE TEAM)
                HStack(spacing: 26) {
                    VStack(spacing: 20) {
                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup1SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup1SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup1SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup1SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup1SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup2SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup2SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup2SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup2SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup2SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup3SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup3SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup3SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup3SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup3SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup4SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup4SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup4SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup4SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup4SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup5SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup5SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup5SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup5SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup5SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup6SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup6SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup6SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup6SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup6SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup7SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup7SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup7SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup7SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup7SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup8SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup8SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup8SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup8SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup8SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }

                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup9SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup9SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup9SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup9SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup9SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupBlueWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup10SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup10SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup10SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup10SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isLeftCup10SunkAnimationActive) { _, newValue in
                                if newValue {
                                    leftSideScore += 1
                                } else {
                                    leftSideScore -= 1
                                }
                            }
                    }
                }


                Spacer()


                // MARK: - RIGHT RACK (RED TEAM)
                HStack(spacing: 26) {
                    VStack(spacing: 20) {
                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup1SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup1SunkAnimationActive ? 6 : 0,
                                    y: isRightCup1SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup1SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup1SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup2SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup2SunkAnimationActive ? 6 : 0,
                                    y: isRightCup2SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup2SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup2SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup3SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup3SunkAnimationActive ? 6 : 0,
                                    y: isRightCup3SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup3SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup3SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup4SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup4SunkAnimationActive ? 6 : 0,
                                    y: isRightCup4SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup4SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup4SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup5SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup5SunkAnimationActive ? 6 : 0,
                                    y: isRightCup5SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup5SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup5SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup6SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup6SunkAnimationActive ? 6 : 0,
                                    y: isRightCup6SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup6SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup6SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }
                    }

                    VStack(spacing: 20) {
                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup7SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup7SunkAnimationActive ? 6 : 0,
                                    y: isRightCup7SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup7SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup7SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup8SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup8SunkAnimationActive ? 6 : 0,
                                    y: isRightCup8SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup8SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup8SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup9SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup9SunkAnimationActive ? 6 : 0,
                                    y: isRightCup9SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup9SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup9SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
                            }

                        Image("SoloCupRedWhiteRim")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup10SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup10SunkAnimationActive ? 6 : 0,
                                    y: isRightCup10SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup10SunkAnimationActive.toggle()
                                }
                            }
                            .onChange(of: isRightCup10SunkAnimationActive) { _, newValue in
                                if newValue {
                                    rightSideScore += 1
                                } else {
                                    rightSideScore -= 1
                                }
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
