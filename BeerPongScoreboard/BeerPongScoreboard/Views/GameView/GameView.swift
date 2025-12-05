import SwiftUI

struct GameView: View {
    @State private var isRulesSafariViewPresented = false


    var body: some View {
        VStack {
            ScoreboardView()
            BeerPongTableView()
        }
        .sheet(isPresented: $isRulesSafariViewPresented) {
            SafariView(url: URL(string: "https://www.probeersports.com/beer-pong")!)
                .ignoresSafeArea()
        }
    }
}
