import SwiftUI

struct BeerPongTableView: View {
    @Environment(AppData.self) private var appData: AppData

    var body: some View {
        HStack {
            Team1RackView()
            Spacer()
            Team2RackView()
        }


    }
}

