import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Table", systemImage: "table.furniture") {
                NavigationStack {
                    BeerPongTableView()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
