import SwiftUI
import SwiftData

@main
struct BeerPongScoreboardApp: App {
    @State private var appData = AppData()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartingView()
            }
            .environment(appData)
            .modelContainer(for: [
                TeamEntity.self,
                PlayerEntity.self
            ])
        }
    }
}



// to use
// @Environment(\.modelContext) private var modelContext
// @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]

