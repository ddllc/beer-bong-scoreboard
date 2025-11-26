import SwiftUI
import SwiftData
import PhotosUI

struct AddPlayerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var team: TeamEntity

    let replaceIndex: Int?

    @State private var name: String = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var photoData: Data?

    var body: some View {
        Form {
            playerSection
            actionSection
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

    // Split sections to simplify type checking
    private var playerSection: some View {
        Section("Player") {
            TextField("Name", text: $name)

            PhotosPicker(selection: $photoItem, matching: .images) {
                PhotosPickerLabelView(hasPhoto: photoData != nil)
            }
        }
    }

    private var actionSection: some View {
        Section {
            Button(replaceIndex == nil ? "Add Player" : "Replace Player") {

                // ✅ hard guard for safety
                if replaceIndex == nil && team.players.count >= 2 {
                    return
                }

                // Use the full initializer that PlayerEntity defines
                let newPlayer = PlayerEntity(
                    id: UUID(),
                    name: name,
                    team: team.name,
                    photoData: photoData,
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
}

