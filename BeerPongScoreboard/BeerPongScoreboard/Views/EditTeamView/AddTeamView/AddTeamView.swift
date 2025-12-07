import SwiftUI
import PhotosUI
import SwiftData

struct AddTeamView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    // MARK: - Focus
    private enum Field: Hashable {
        case teamName
        case player1Name
        case player2Name
    }

    @FocusState private var focusedField: Field?

    @State private var teamName = ""
    @State private var teamPhotoPickerItem: PhotosPickerItem?
    @State private var teamPhotoData: Data?

    @State private var player1Name = ""
    @State private var player1PhotoPickerItem: PhotosPickerItem?
    @State private var player1PhotoData: Data?

    @State private var player2Name = ""
    @State private var player2PhotoPickerItem: PhotosPickerItem?
    @State private var player2PhotoData: Data?

    private let avatarSize: CGFloat = 80

    private var isSaveDisabled: Bool {
        teamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        player1Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        player2Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        List {
            // MARK: - Team Section
            Section("Team") {
                HStack(spacing: 16) {
                    PhotosPicker(selection: $teamPhotoPickerItem) {
                        Group {
                            if let teamPhotoData,
                               let uiImage = UIImage(data: teamPhotoData) {
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
                                    .clipShape(Circle())
                            }
                        }
                    }

                    TextField("Team Name", text: $teamName)
                        .focused($focusedField, equals: .teamName)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .player1Name
                        }
                }
                .onChange(of: teamPhotoPickerItem) {
                    guard let teamPhotoPickerItem else { return }
                    Task {
                        teamPhotoData = try await teamPhotoPickerItem.loadTransferable(type: Data.self)
                    }
                }
            }

            // MARK: - Player 1
            Section("Players") {
                HStack(spacing: 16) {
                    PhotosPicker(selection: $player1PhotoPickerItem) {
                        Group {
                            if let player1PhotoData,
                               let uiImage = UIImage(data: player1PhotoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: avatarSize, height: avatarSize)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: avatarSize, height: avatarSize)
                                    .clipShape(Circle())
                            }
                        }
                    }

                    TextField("Player 1 Name", text: $player1Name)
                        .focused($focusedField, equals: .player1Name)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .player2Name
                        }
                }
                .onChange(of: player1PhotoPickerItem) {
                    guard let player1PhotoPickerItem else { return }
                    Task {
                        player1PhotoData = try await player1PhotoPickerItem.loadTransferable(type: Data.self)
                    }
                }

                HStack(spacing: 16) {
                    PhotosPicker(selection: $player2PhotoPickerItem) {
                        Group {
                            if let player2PhotoData,
                               let uiImage = UIImage(data: player2PhotoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: avatarSize, height: avatarSize)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: avatarSize, height: avatarSize)
                                    .clipShape(Circle())
                            }
                        }
                    }

                    TextField("Player 2 Name", text: $player2Name)
                        .focused($focusedField, equals: .player2Name)
                        .submitLabel(.done)
                        .onSubmit {
                            if !isSaveDisabled {
                                saveTeam()
                            } else {
                                focusedField = nil
                            }
                        }
                }
                .onChange(of: player2PhotoPickerItem) {
                    guard let player2PhotoPickerItem else { return }
                    Task {
                        player2PhotoData = try await player2PhotoPickerItem.loadTransferable(type: Data.self)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Add Team")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveTeam() }
                    .disabled(isSaveDisabled)
            }
        }
        .onAppear {
            focusedField = .teamName
        }
    }

    // MARK: - Save to SwiftData
    private func saveTeam() {
        // Trim names
        let trimmedTeamName = teamName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPlayer1Name = player1Name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPlayer2Name = player2Name.trimmingCharacters(in: .whitespacesAndNewlines)

        // Create player and team entities
        var playerEntities: [PlayerEntity] = []
            let player1Entity = PlayerEntity(
                id: UUID(),
                name: trimmedPlayer1Name,
                team: trimmedTeamName,
                photoData: player1PhotoData
            )
            playerEntities.append(player1Entity)

            let player2Entity = PlayerEntity(
                id: UUID(),
                name: trimmedPlayer2Name,
                team: trimmedTeamName,
                photoData: player2PhotoData
            )
            playerEntities.append(player2Entity)


        let teamEntity = TeamEntity(
            name: trimmedTeamName,
            players: playerEntities,
            photoData: teamPhotoData,
            wins: 0,
            losses: 0,
            totalCupsSunk: 0,
            totalCupsAllowed: 0
        )

        // Save entities
        modelContext.insert(teamEntity)
        do {
            try modelContext.save()
            print("✅ SwiftData save succeeded for team '\(trimmedTeamName)'")
        } catch {
            print("❌ SwiftData save failed: \(error)")
        }

        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddTeamView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
