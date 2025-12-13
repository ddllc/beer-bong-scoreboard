import SwiftUI

struct BeerPongTableView: View {
    @Binding var game: GameModel
    let cupSize: CGFloat = 55

    // TEMP: experimenting state (one boolean per cup, super explicit for juniors)

    // Left rack (5 + 4 + 3 + 2 + 1 = 15 cups)
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
    @State private var isLeftCup11SunkAnimationActive = false
    @State private var isLeftCup12SunkAnimationActive = false

    @State private var isLeftCup13SunkAnimationActive = false
    @State private var isLeftCup14SunkAnimationActive = false

    @State private var isLeftCup15SunkAnimationActive = false

    // Right rack (1 + 2 + 3 + 4 + 5 = 15 cups)
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

    @State private var isRightCup11SunkAnimationActive = false
    @State private var isRightCup12SunkAnimationActive = false
    @State private var isRightCup13SunkAnimationActive = false
    @State private var isRightCup14SunkAnimationActive = false
    @State private var isRightCup15SunkAnimationActive = false

    var body: some View {
        GeometryReader { proxy in

            let safeAreaLeadingInset = proxy.safeAreaInsets.leading
            let safeAreaTrailingInset = proxy.safeAreaInsets.trailing
            let extraHorizontalPadding: CGFloat = 16

            HStack(alignment: .center, spacing: 0) {

                // MARK: - LEFT RACK (BLUE TEAM)
                HStack(spacing: 20) {

                    // 5 cups (Left)
                    VStack(spacing: 0) {

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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
                    }

                    // 4 cups (Left)
                    VStack(spacing: 0) {

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
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
                    }

                    // 3 cups (Left)
                    VStack(spacing: 0) {

                        Image("SoloCupBlue") // ✅ BLUE
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

                        Image("SoloCupBlue") // ✅ BLUE
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup11SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup11SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup11SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup11SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupBlue") // ✅ BLUE
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup12SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup12SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup12SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup12SunkAnimationActive.toggle()
                                }
                            }
                    }

                    // 2 cups (Left)
                    VStack(spacing: 0) {

                        Image("SoloCupBlue") // ✅ BLUE
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup13SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup13SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup13SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup13SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupBlue") // ✅ BLUE
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup14SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup14SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup14SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup14SunkAnimationActive.toggle()
                                }
                            }
                    }

                    // 1 cup (Left)
                    VStack(spacing: 0) {

                        Image("SoloCupBlue") // ✅ BLUE
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isLeftCup15SunkAnimationActive ? -60 : 0), anchor: .bottom)
                            .offset(x: isLeftCup15SunkAnimationActive ? -6 : 0,
                                    y: isLeftCup15SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isLeftCup15SunkAnimationActive.toggle()
                                }
                            }
                    }
                }

                // CENTER DIVIDER LINE
                Rectangle()
                    .fill(.white)
                    .frame(width: 2)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 16)

                // MARK: - RIGHT RACK (RED TEAM)
                HStack(spacing: 20) {

                    VStack(spacing: 0) {
                        Image("SoloCupRed")
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
                    }

                    VStack(spacing: 0) {
                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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
                    }

                    VStack(spacing: 0) {
                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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
                    }

                    VStack(spacing: 0) {
                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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

                        Image("SoloCupRed")
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
                    }

                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup11SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup11SunkAnimationActive ? 6 : 0,
                                    y: isRightCup11SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup11SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup12SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup12SunkAnimationActive ? 6 : 0,
                                    y: isRightCup12SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup12SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup13SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup13SunkAnimationActive ? 6 : 0,
                                    y: isRightCup13SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup13SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup14SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup14SunkAnimationActive ? 6 : 0,
                                    y: isRightCup14SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup14SunkAnimationActive.toggle()
                                }
                            }

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                            .rotationEffect(.degrees(isRightCup15SunkAnimationActive ? 60 : 0), anchor: .bottom)
                            .offset(x: isRightCup15SunkAnimationActive ? 6 : 0,
                                    y: isRightCup15SunkAnimationActive ? 6 : 0)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeOut(duration: 0.18)) {
                                    isRightCup15SunkAnimationActive.toggle()
                                }
                            }
                    }
                }
            }
            // Dynamic Island / notch safe area padding
            .padding(.leading, safeAreaLeadingInset + extraHorizontalPadding)
            .padding(.trailing, safeAreaTrailingInset + extraHorizontalPadding)
        }
    }
}
