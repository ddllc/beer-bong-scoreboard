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


// MARK: - EditTeamDetailView

struct EditTeamDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var team: TeamEntity

    @State private var teamPhotoItem: PhotosPickerItem?
    @State private var isAddPlayerPresented = false

    // Replace-player flow
    @State private var showReplaceDialog = false
    @State private var replaceIndex: Int? = nil

    // Back / Save validation
    @State private var showInvalidTeamAlert = false
    @State private var allowPop = false  // when true, we allow swipe/back

    private let bigAvatarSize: CGFloat = 96
    private let playerAvatarSize: CGFloat = 40

    var body: some View {
        Form {

            // MARK: Team Header
            Section {
                VStack(spacing: 12) {

                    PhotosPicker(selection: $teamPhotoItem, matching: .images) {
                        ZStack {
                            if let data = team.photoData,
                               let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 32))
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(width: bigAvatarSize, height: bigAvatarSize)
                        .clipShape(Circle())
                    }
                    .buttonStyle(.plain)

                    TextField("Team name", text: $team.name)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }

            // MARK: Wins / Losses
            Section("Record") {
                Stepper("Wins: \(team.wins)", value: $team.wins, in: 0...10_000)
                Stepper("Losses: \(team.losses)", value: $team.losses, in: 0...10_000)
            }

            // MARK: Players
            Section {
                if team.players.isEmpty {
                    Text("No players yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(team.players) { player in
                        PlayerRow(player: player, size: playerAvatarSize)
                    }
                    .onDelete(perform: deletePlayers)
                }

                if team.players.count >= 2 {
                    Text("Team is full (2 players max). Replace a player to add someone new.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Text("A team needs exactly 2 players to be valid.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

            } header: {
                HStack {
                    Text("Players")
                    Spacer()

                    Button {
                        if team.players.count < 2 {
                            replaceIndex = nil
                            isAddPlayerPresented = true
                        } else {
                            showReplaceDialog = true
                        }
                    } label: {
                        Label("Add Player", systemImage: "plus")
                    }
                    .font(.subheadline)
                }
            }
        }
        .navigationTitle(team.name)
        .navigationBarTitleDisplayMode(.inline)

        // ✅ hide system back button so user can't pop without our logic
        .navigationBarBackButtonHidden(true)

        // ✅ disable swipe-back unless allowPop == true
        .modifier(DisableSwipeBack(isEnabled: team.players.count == 2 || allowPop))

        // MARK: Toolbar (Back + Save)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    handleBack()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    handleSave()
                }
            }
        }

        // MARK: Replace player dialog
        .confirmationDialog(
            "Team Full",
            isPresented: $showReplaceDialog,
            titleVisibility: .visible
        ) {
            if team.players.indices.contains(0) {
                Button("Replace \(team.players[0].name)") {
                    replaceIndex = 0
                    isAddPlayerPresented = true
                }
            }
            if team.players.indices.contains(1) {
                Button("Replace \(team.players[1].name)") {
                    replaceIndex = 1
                    isAddPlayerPresented = true
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This team already has 2 players. Who do you want to replace?")
        }

        // MARK: Add Player Sheet
        .sheet(isPresented: $isAddPlayerPresented) {
            NavigationStack {
                AddPlayerSheetView(team: team, replaceIndex: replaceIndex)
            }
        }

        // MARK: Invalid team alert
        .alert("Team Needs 2 Players", isPresented: $showInvalidTeamAlert) {
            Button("Stay Here", role: .cancel) {}

            Button("Delete Team", role: .destructive) {
                modelContext.delete(team)
                try? modelContext.save()
                allowPop = true
                dismiss()
            }
        } message: {
            Text("A beer pong team must have exactly 2 players before leaving this screen.")
        }

        // Handle team photo
        .onChange(of: teamPhotoItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    team.photoData = data
                    try? modelContext.save()
                }
            }
        }
    }

    private func handleBack() {
        if team.players.count != 2 {
            showInvalidTeamAlert = true
            return
        }
        allowPop = true
        dismiss()
    }

    private func handleSave() {
        if team.players.count != 2 {
            showInvalidTeamAlert = true
            return
        }
        try? modelContext.save()
        allowPop = true
        dismiss()
    }

    private func deletePlayers(at offsets: IndexSet) {
        for index in offsets {
            let player = team.players[index]
            modelContext.delete(player)
        }
        try? modelContext.save()
    }
}



// MARK: - Player Row (editable name + photo)

private struct PlayerRow: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var player: PlayerEntity

    let size: CGFloat
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        HStack(spacing: 12) {

            PhotosPicker(selection: $photoItem, matching: .images) {
                if let data = player.photoData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            TextField("Player name", text: $player.name)

            Spacer()
        }
        .onChange(of: photoItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    player.photoData = data
                    try? modelContext.save()
                }
            }
        }
    }
}


// MARK: - Add Player Sheet

struct AddPlayerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var team: TeamEntity

    // ✅ if non-nil, we replace that index
    let replaceIndex: Int?

    @State private var name: String = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?

    var body: some View {
        Form {
            Section("Player") {
                TextField("Name", text: $name)

                PhotosPicker(selection: $photoItem, matching: .images) {
                    HStack {
                        Image(systemName: "photo")
                        Text(photoData == nil ? "Pick Photo" : "Change Photo")
                    }
                }
            }

            Section {
                Button(replaceIndex == nil ? "Add Player" : "Replace Player") {

                    // ✅ hard guard for safety
                    if replaceIndex == nil && team.players.count >= 2 {
                        return
                    }

                    let newPlayer = PlayerEntity(
                        name: name,
                        team: team.name,
                        photoData: photoData
                    )

                    if let replaceIndex,
                       team.players.indices.contains(replaceIndex) {

                        let oldPlayer = team.players[replaceIndex]
                        modelContext.delete(oldPlayer)

                        // keep order: remove old at index, insert new at same index
                        team.players.remove(at: replaceIndex)
                        team.players.insert(newPlayer, at: replaceIndex)

                    } else {
                        team.players.append(newPlayer)
                    }

                    try? modelContext.save()
                    dismiss()
                }
                .disabled(
                    name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    (replaceIndex == nil && team.players.count >= 2)
                )
            }
        }
        .navigationTitle(replaceIndex == nil ? "Add Player" : "Replace Player")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
        }
        .onChange(of: photoItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    photoData = data
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditTeamView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}


/// Disables the interactive swipe-back gesture for a NavigationStack push.
/// Uses UIKit under the hood.
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
