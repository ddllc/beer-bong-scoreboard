import SwiftUI

struct GameView: View {
    @State private var game: GameModel

    init(game: GameModel) {
        _game = State(initialValue: game)
    }

    var body: some View {

        VStack {
                ScoreboardView(game: $game)
                BeerPongTableView(game: $game)
            Spacer()
            }
        .navigationBarBackButtonHidden(true)
    }
}
