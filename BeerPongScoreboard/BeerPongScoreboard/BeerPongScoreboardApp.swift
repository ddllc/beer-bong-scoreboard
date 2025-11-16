import SwiftUI

@main
struct BeerPongScoreboardApp: App {
    @State private var appData = AppData()

    var body: some Scene {
        WindowGroup {
            BeerPongTableView()
                .environment(appData)
        }
    }
}
