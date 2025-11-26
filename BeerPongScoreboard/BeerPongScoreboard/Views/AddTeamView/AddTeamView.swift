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

    private let avatarSize: CGFloat = 80

    private var isSaveDisabled: Bool {
        teamName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        player1Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        player2Name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

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
            .disabled(isSaveDisabled)

            Spacer()
        }
        .padding()
    }

    // MARK: - Save Logic (SwiftData)
    private func saveTeam() {
        let trimmedTeamName = teamName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTeamName.isEmpty else {
            print("⚠️ saveTeam aborted: team name is empty")
            return
        }

        let trimmedP1 = player1Name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedP2 = player2Name.trimmingCharacters(in: .whitespacesAndNewlines)

        print("ℹ️ saveTeam called with:")
        print("   • Team: '\(trimmedTeamName)'")
        print("   • Player 1: '\(trimmedP1)' (has photo: \(player1PhotoData != nil))")
        print("   • Player 2: '\(trimmedP2)' (has photo: \(player2PhotoData != nil))")

        var playerEntities: [PlayerEntity] = []

        // Player 1
        if !trimmedP1.isEmpty {
            let p1 = PlayerEntity(
                id: UUID(),
                name: trimmedP1,
                team: trimmedTeamName,
                photoData: player1PhotoData,
                rpsWins: 0,
                rpsTies: 0,
                rpsLosses: 0,
                successfulThrows: 0,
                missedThrows: 0,
                currentHotStreak: 0,
                longestHotStreak: 0,
                currentColdStreak: 0,
                longestColdStreak: 0,
                lastCupSuccessfulThrows: 0,
                lastCupMissedThrows: 0,
                rebuttalCupSuccessfulThrows: 0,
                rebuttalCupMissedThrows: 0
            )
            playerEntities.append(p1)
        } else {
            print("⚠️ Player 1 name empty, not creating entity")
        }

        // Player 2
        if !trimmedP2.isEmpty {
            let p2 = PlayerEntity(
                id: UUID(),
                name: trimmedP2,
                team: trimmedTeamName,
                photoData: player2PhotoData,
                rpsWins: 0,
                rpsTies: 0,
                rpsLosses: 0,
                successfulThrows: 0,
                missedThrows: 0,
                currentHotStreak: 0,
                longestHotStreak: 0,
                currentColdStreak: 0,
                longestColdStreak: 0,
                lastCupSuccessfulThrows: 0,
                lastCupMissedThrows: 0,
                rebuttalCupSuccessfulThrows: 0,
                rebuttalCupMissedThrows: 0
            )
            playerEntities.append(p2)
        } else {
            print("⚠️ Player 2 name empty, not creating entity")
        }

        print("ℹ️ About to create TeamEntity with \(playerEntities.count) players")

        let teamEntity = TeamEntity(
            name: trimmedTeamName,
            players: playerEntities,
            photoData: teamPhotoData,
            wins: 0,
            losses: 0,
            overtimeWins: 0,
            overtimeLosses: 0,
            totalCupsHit: 0,
            totalCupsHitAgainst: 0,
            currentWinningStreak: 0,
            currentLosingStreak: 0,
            longestWinningStreak: 0,
            longestLosingStreak: 0,
            currentHotStreak: 0,
            currentColdStreak: 0,
            longestHotStreak: 0,
            longestColdStreak: 0,
            rebuttalAttempts: 0,
            successfulRebuttals: 0,
            bonusShotAttempts: 0,
            bonusShotMakes: 0
        )

        print("ℹ️ Inserting TeamEntity id=\(teamEntity.id) into modelContext")
        modelContext.insert(teamEntity)

        do {
            try modelContext.save()
            print("✅ SwiftData save succeeded for team '\(trimmedTeamName)'")
            print("   • Players saved: \(teamEntity.players.count)")
        } catch {
            print("❌ SwiftData save failed: \(error)")
            let nsError = error as NSError
            print("   ↪️ NSError: \(nsError), userInfo: \(nsError.userInfo)")
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
