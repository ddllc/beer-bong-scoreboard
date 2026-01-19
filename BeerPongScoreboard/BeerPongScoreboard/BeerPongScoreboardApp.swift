import SwiftUI
import SwiftData

@main
struct BeerPongScoreboardApp: App {
    @State private var navigationPath = NavigationPath()
    @State private var appData = AppData()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                StartingView(navigationPath: $navigationPath)
            }
            .environment(appData)
            .modelContainer(for: [
                TeamEntity.self,
                PlayerEntity.self
            ])

        }
    }
}
