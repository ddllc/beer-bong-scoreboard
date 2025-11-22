import SwiftUI
import PhotosUI
import SwiftData

struct AddTeamView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var teamName = ""
    @State private var teamPhotoPickerItem: PhotosPickerItem?
    @State private var teamPhotoData: Data?

    @State private var player1Name = ""
    @State private var player1PhotoPickerItem: PhotosPickerItem?
    @State private var player1PhotoData: Data?

    @State private var player2Name = ""
    @State private var player2PhotoPickerItem: PhotosPickerItem?
    @State private var player2PhotoData: Data?

    private let avatarSize: CGFloat = 80   // unified size for ALL photos

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
            }

            HStack {
                Text("Add A Team")
                    .font(.title)
                    .bold()
            }

            // MARK: - Team Row
            HStack {
                PhotosPicker(selection: $teamPhotoPickerItem) {
                    Group {
                        if let teamPhotoData,
                           let uiImage = UIImage(data: teamPhotoData) {

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: avatarSize, height: avatarSize)
                                .clipShape(Circle())
                                .clipped()

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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .padding()
            .onChange(of: teamPhotoPickerItem) {
                guard let teamPhotoPickerItem else { return }
                Task {
                    teamPhotoData = try await teamPhotoPickerItem.loadTransferable(type: Data.self)
                }
            }

            Divider()

            // MARK: - Player 1 Row
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
                                .clipped()

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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .padding()
            .onChange(of: player1PhotoPickerItem) {
                guard let player1PhotoPickerItem else { return }
                Task {
                    player1PhotoData = try await player1PhotoPickerItem.loadTransferable(type: Data.self)
                }
            }

            Divider()

            // MARK: - Player 2 Row
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
                                .clipped()

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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .padding()
            .onChange(of: player2PhotoPickerItem) {
                guard let player2PhotoPickerItem else { return }
                Task {
                    player2PhotoData = try await player2PhotoPickerItem.loadTransferable(type: Data.self)
                }
            }

            Divider()

            // MARK: - Save Button
            Button("Save") {
                saveTeam()
            }
            .buttonSizing(.flexible)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .buttonStyle(.glassProminent)
            .padding()
            .disabled(teamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Spacer()
        }
        .padding()
    }

    // MARK: - Save Logic (SwiftData)
    private func saveTeam() {
        let trimmedTeamName = teamName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTeamName.isEmpty else { return }

        let trimmedP1 = player1Name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedP2 = player2Name.trimmingCharacters(in: .whitespacesAndNewlines)

        var playerEntities: [PlayerEntity] = []

        if !trimmedP1.isEmpty {
            let p1 = PlayerEntity(name: trimmedP1, team: trimmedTeamName)
            // TODO: if you add photoData to PlayerEntity later, set it here
            // p1.photoData = player1PhotoData
            playerEntities.append(p1)
        }

        if !trimmedP2.isEmpty {
            let p2 = PlayerEntity(name: trimmedP2, team: trimmedTeamName)
            // TODO: if you add photoData to PlayerEntity later, set it here
            // p2.photoData = player2PhotoData
            playerEntities.append(p2)
        }

        let teamEntity = TeamEntity(name: trimmedTeamName, players: playerEntities)
        // TODO: if you add photoData to TeamEntity later, set it here
        // teamEntity.photoData = teamPhotoData

        modelContext.insert(teamEntity)

        // Optional: force a save immediately (SwiftData usually autosaves)
        do {
            try modelContext.save()
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
