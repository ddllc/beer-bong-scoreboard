import SwiftUI
import SwiftData

struct EditTeamsView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \TeamEntity.name) private var allTeams: [TeamEntity]
    @State private var searchText = ""

    private var filteredTeams: [TeamEntity] {
        guard !searchText.isEmpty else { return allTeams }

        let query = searchText.lowercased()

        return allTeams.filter { team in
            let teamMatches = team.name.lowercased().contains(query)
            let playersMatch = team.players.contains { $0.name.lowercased().contains(query) }
            return teamMatches || playersMatch
        }
    }

    var body: some View {
        List {
            if filteredTeams.isEmpty {
                ContentUnavailableView(
                    "No Teams Found",
                    systemImage: "person.2.fill",
                    description: Text("Try searching for a different name.")
                )
            } else {
                ForEach(filteredTeams) { team in
                    NavigationLink {
                        EditTeamDetailView(team: team)
                    } label: {
                        EditTeamsRowView(team: team)
                    }
                }
                .onDelete(perform: deleteTeams)
            }
        }
        .searchable(text: $searchText, prompt: "Search teams or players")
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Edit Teams")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddTeamView()) {
                    Label("Add Team", systemImage: "plus")
                }
            }

            if !filteredTeams.isEmpty {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }

    private func deleteTeams(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredTeams[index])
        }
        try? modelContext.save()
    }
}
