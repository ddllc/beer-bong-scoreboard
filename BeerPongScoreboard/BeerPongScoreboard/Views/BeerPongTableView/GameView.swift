import SwiftUI

struct GameView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var isPortrait: Bool {
        verticalSizeClass == .regular
    }

    var body: some View {
        Group {
            if isPortrait {
                VStack(spacing: 24) {
                    Image(systemName: "iphone.rotate")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)

                    Text("Please rotate your device")
                        .font(.title.bold())

                    Text("Game is best played in landscape mode.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
            } else {
                // Your real game table
                BeerPongTableView()
            }
        }
        .animation(.easeInOut, value: isPortrait)
    }
}
