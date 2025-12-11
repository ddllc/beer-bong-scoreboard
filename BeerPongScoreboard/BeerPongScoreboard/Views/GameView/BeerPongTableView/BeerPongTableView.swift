import SwiftUI

struct BeerPongTableView: View {
    @Binding var game: GameModel
    let cupSize: CGFloat = 55

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    // 5 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 4 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 3 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 2 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 1 cup
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                }

                Spacer()

                HStack {
                    // 1 cup
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 2 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 3 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 4 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }

                    // 5 cups
                    VStack(spacing: 0) {
                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)

                        Image("SoloCupRed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: cupSize, height: cupSize)
                    }
                }
            }
        }
    }
}
