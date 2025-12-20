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
        .onChange(of: game.team1CupsSunk) { oldValue, newValue in
            print("------------in gameview")
            print("old value: \(game.team1CupsSunk)")
            print("new Value: \(game.team1CupsSunk)")
            print("------------in gameview")
        }
        .navigationBarBackButtonHidden(true)
    }
}
