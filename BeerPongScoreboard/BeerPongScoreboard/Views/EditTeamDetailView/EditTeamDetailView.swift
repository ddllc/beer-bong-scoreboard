import SwiftUI
import SwiftData
import PhotosUI

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

            // MARK: Players
            Section {
                if team.players.isEmpty {
                    Text("No players yet")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(team.players) { player in
                        PlayerRowView(player: player, size: playerAvatarSize)
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
        .modifier(DisableSwipeBackModifier(isEnabled: team.players.count == 2 || allowPop))

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
