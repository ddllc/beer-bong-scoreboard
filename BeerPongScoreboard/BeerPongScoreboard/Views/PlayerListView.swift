import SwiftUI

struct PlayerListView: View {
    @Binding var players: [String]
    @Binding var selectedPlayerOne: String?
    @Binding var selectedPlayerTwo: String?

    @State private var newPlayerName: String = ""

    var body: some View {
        List {
            Section("Players") {
                ForEach(players.indices, id: \.self) { i in
                    let name = players[i]
                    HStack {
                        TextField("Name", text: $players[i])
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                        // Assign as Player 1
                        Button("Player 1") {
                            if selectedPlayerOne == name {
                                selectedPlayerOne = nil
                            } else {
                                selectedPlayerOne = name
                                if selectedPlayerTwo == name {
                                    selectedPlayerTwo = nil
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedPlayerOne == name ? .blue : .gray)

                        // Assign as Player 2
                        Button("Player 2") {
                            if selectedPlayerTwo == name {
                                selectedPlayerTwo = nil
                            } else {
                                selectedPlayerTwo = name
                                if selectedPlayerOne == name {
                                    selectedPlayerOne = nil
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(selectedPlayerTwo == name ? .green : .gray)
                    }
                }
                .onDelete { indexSet in
                    players.remove(atOffsets: indexSet)
                }
            }
            Section("Add Player") {
                HStack {
                    TextField("Name", text: $newPlayerName)
                    Button("Add") {
                        let trimmed = newPlayerName.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        if !players.contains(trimmed) { players.append(trimmed) }
                        newPlayerName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Players")
    }
}

#Preview {
    @State var players = ["Alex", "Blake", "Casey"]
    @State var p1: String? = "Alex"
    @State var p2: String? = "Blake"
    return NavigationStack { PlayerListView(players: $players, selectedPlayerOne: $p1, selectedPlayerTwo: $p2) }
}

