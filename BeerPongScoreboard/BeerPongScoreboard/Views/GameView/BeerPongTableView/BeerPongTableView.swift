import SwiftUI

struct BeerPongTableView: View {
    @Binding var game: GameModel

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }


    }
}

