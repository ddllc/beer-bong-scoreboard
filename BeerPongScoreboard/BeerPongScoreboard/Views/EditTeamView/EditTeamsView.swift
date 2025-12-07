import SwiftUI
import SwiftData

struct EditTeamsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]

    var body: some View {
        List {
            if teams.isEmpty {
                ContentUnavailableView("No Teams Yet",
                                       systemImage: "person.2.fill",
                                       description: Text("Tap Add to create your first team."))
            } else {
                ForEach(teams) { team in
                    NavigationLink {
//                        EditTeamDetailView(team: team)
                    } label: {
                        EditTeamsRowView(team: team)
                    }
                }
                .onDelete(perform: deleteTeams)
            }
        }
        .navigationTitle("Edit Teams")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddTeamView()) {
                    Label("Add Team", systemImage: "plus")
                }
            }

            if !teams.isEmpty {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }

    private func deleteTeams(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(teams[index])
        }
        try? modelContext.save()
    }
}

#Preview {
    NavigationStack {
        EditTeamsView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
