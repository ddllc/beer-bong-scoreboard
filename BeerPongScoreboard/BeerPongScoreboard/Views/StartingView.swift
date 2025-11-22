import SwiftUI
import SwiftData

struct StartingView: View {
    @State private var isAddTeamSheetPresented = false

    // Pull teams from SwiftData (auto-updates)
    @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]

    // Two selections
    @State private var selectedTeam1: TeamEntity?
    @State private var selectedTeam2: TeamEntity?

    private let avatarSize: CGFloat = 72

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Beer Pong Scoreboard")
                    .font(.title)
                    .bold()
            }

            HStack {
                // MARK: - Team 1 Picker
                Picker("Select Team 1", selection: $selectedTeam1) {
                    Text("Select Team").tag(TeamEntity?.none)

                    ForEach(teams.filter { team in
                        team.id != selectedTeam2?.id
                    }) { team in
                        Text(team.name).tag(TeamEntity?.some(team))
                    }
                }
                .pickerStyle(.menu)

                Spacer()

                // MARK: - Team 2 Picker
                Picker("Pick Team 2", selection: $selectedTeam2) {
                    Text("Select Team").tag(TeamEntity?.none)

                    ForEach(teams.filter { team in
                        team.id != selectedTeam1?.id
                    }) { team in
                        Text(team.name).tag(TeamEntity?.some(team))
                    }
                }
                .pickerStyle(.menu)
            }

            // MARK: - Matchup Summary (Vertical Stack)
            VStack(spacing: 12) {
                if let team1 = selectedTeam1 {
                    teamSummaryView(team: team1)
                } else {
                    emptyTeamSummary(label: "Team 1")
                }

                Text("VS.")
                    .font(.title2)
                    .bold()
                    .padding(.vertical, 4)

                if let team2 = selectedTeam2 {
                    teamSummaryView(team: team2)
                } else {
                    emptyTeamSummary(label: "Team 2")
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Spacer()

            // MARK: - Start Game Button (No Action Yet)
            Button("Start Game") {
                // TODO: add action later
            }
            .buttonStyle(.glassProminent)
            .buttonSizing(.flexible)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .padding()
            .disabled(
                selectedTeam1 == nil ||
                selectedTeam2 == nil ||
                selectedTeam1?.id == selectedTeam2?.id
            )
        }
        .padding()
        .fullScreenCover(isPresented: $isAddTeamSheetPresented) {
            NavigationStack {
                AddTeamView()
            }
        }
        .onAppear {
            if selectedTeam1 == nil { selectedTeam1 = teams.first }
            if selectedTeam2 == nil { selectedTeam2 = teams.dropFirst().first }
        }
        .onChange(of: teams) {
            if selectedTeam1 == nil { selectedTeam1 = teams.first }
            if selectedTeam2 == nil { selectedTeam2 = teams.dropFirst().first }

            if selectedTeam1?.id == selectedTeam2?.id {
                selectedTeam2 = nil
            }
        }
        .onChange(of: selectedTeam1) {
            if selectedTeam1?.id == selectedTeam2?.id {
                selectedTeam2 = nil
            }
        }
        .onChange(of: selectedTeam2) {
            if selectedTeam2?.id == selectedTeam1?.id {
                selectedTeam1 = nil
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Add Team") {
                    isAddTeamSheetPresented = true
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    // MARK: - Team Summary View
    @ViewBuilder
    private func teamSummaryView(team: TeamEntity) -> some View {
        HStack(spacing: 12) {
            // Team photo (if available)
            if let data = team.photoData,  // <-- add photoData to TeamEntity later
               let uiImage = UIImage(data: data) {
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

            VStack(alignment: .leading, spacing: 4) {
                Text(team.name)
                    .font(.headline)

                // Player names
                if team.players.isEmpty {
                    Text("No players")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    Text(team.players.map { $0.name }.joined(separator: " & "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
    }

    // MARK: - Empty Summary Placeholder
    @ViewBuilder
    private func emptyTeamSummary(label: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text("Select a team")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        StartingView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
