import SwiftUI
import SwiftData
import PhotosUI

struct EditTeamDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var team: TeamEntity

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
        // 1. Required fields must not be empty
        let requiredFieldsEmpty =
            teamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            player1Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            player2Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        // 2. Nothing has changed
        let noChanges =
            teamName == team.name &&
            teamPhotoData == team.photoData &&
            player1Name == team.players[0].name &&
            player1PhotoData == team.players[0].photoData &&
            player2Name == team.players[1].name &&
            player2PhotoData == team.players[1].photoData

        return requiredFieldsEmpty || noChanges
    }


    // MARK: - Focus
    private enum Field: Hashable {
        case teamName
        case player1Name
        case player2Name
    }
    @FocusState private var focusedField: Field?

    var body: some View {
        List {
            // MARK: - Team Section
            Section("Team") {
                HStack {
                    PhotosPicker(selection: $teamPhotoPickerItem) {
                        Group {
                            if let displayData = teamPhotoData ?? team.photoData,
                               let uiImage = UIImage(data: displayData) {
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
                        let data = try? await teamPhotoPickerItem.loadTransferable(type: Data.self)
                        teamPhotoData = data
                    }
                }
            }


            // MARK: - Players Section
            Section("Players") {
                HStack {
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

                HStack {
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
                }
                .onChange(of: player2PhotoPickerItem) {
                    guard let player2PhotoPickerItem else { return }
                    Task {
                        player2PhotoData = try await player2PhotoPickerItem.loadTransferable(type: Data.self)
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Edit \(team.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    updateTeam()
                    dismiss()
                }
                .disabled(isSaveDisabled)
            }
        }
        .onAppear {
            teamName = team.name
            teamPhotoData = team.photoData
            player1Name = team.players[0].name
            player1PhotoData = team.players[0].photoData
            player2Name = team.players[1].name
            player2PhotoData = team.players[1].photoData
        }
    }

    private func deletePlayers(at offsets: IndexSet) {
        for index in offsets {
            let player = team.players[index]
            modelContext.delete(player)
        }
        team.players.remove(atOffsets: offsets)
    }

    private func movePlayers(from source: IndexSet, to destination: Int) {
        team.players.move(fromOffsets: source, toOffset: destination)
    }

    private func updateTeam() {
        team.name = teamName
        team.photoData = teamPhotoData
        team.players[0].name = player1Name
        team.players[0].photoData = player1PhotoData
        team.players[1].name = player2Name
        team.players[1].photoData = player2PhotoData
        do {
            try modelContext.save()
        } catch {
            print("Unable to update team: \(error)")
        }
    }
}
