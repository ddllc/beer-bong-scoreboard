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
                        TeamRow(team: team)
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

// MARK: - Row

private struct TeamRow: View {
    let team: TeamEntity
    private let avatarSize: CGFloat = 44

    var body: some View {
        HStack(spacing: 12) {
            if let data = team.photoData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(team.name)
                    .font(.headline)

                Text("\(team.players.count) player\(team.players.count == 1 ? "" : "s")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("W \(team.wins)")
                Text("L \(team.losses)")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}




// MARK: - Add Player Sheet


// Small, simple label view for PhotosPicker to help the compiler

#Preview {
    NavigationStack {
        EditTeamView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}

struct DisableSwipeBack: ViewModifier {
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content
            .background(SwipeBackController(isEnabled: isEnabled))
    }

    private struct SwipeBackController: UIViewControllerRepresentable {
        let isEnabled: Bool

        func makeUIViewController(context: Context) -> UIViewController {
            Controller(isEnabled: isEnabled)
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            (uiViewController as? Controller)?.isEnabled = isEnabled
        }

        private final class Controller: UIViewController {
            var isEnabled: Bool {
                didSet { update() }
            }

            init(isEnabled: Bool) {
                self.isEnabled = isEnabled
                super.init(nibName: nil, bundle: nil)
            }

            required init?(coder: NSCoder) { fatalError() }

            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                update()
            }

            private func update() {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnabled
            }
        }
    }
}
