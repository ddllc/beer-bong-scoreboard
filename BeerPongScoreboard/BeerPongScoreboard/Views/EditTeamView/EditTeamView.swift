import SwiftUI
import SwiftData
import PhotosUI

// MARK: - EditTeamsView (List of teams)

struct EditTeamView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]

    @State private var isAddTeamPresented = false

    var body: some View {
        List {
            if teams.isEmpty {
                ContentUnavailableView("No Teams Yet",
                                       systemImage: "person.3.fill",
                                       description: Text("Tap Add to create your first team."))
            } else {
                ForEach(teams) { team in
                    NavigationLink {
                        EditTeamDetailView(team: team)
                    } label: {
                        TeamRowView(team: team)
                    }
                }
                .onDelete(perform: deleteTeams)
            }
        }
        .navigationTitle("Edit Teams")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddTeamPresented = true
                } label: {
                    Label("Add Team", systemImage: "plus")
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
        }
        .fullScreenCover(isPresented: $isAddTeamPresented) {
            NavigationStack {
                AddTeamView()
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
        EditTeamView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
