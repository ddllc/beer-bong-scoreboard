import SwiftUI
import SwiftData

struct StartingView: View {
    @State private var isShowRulesSheetPresented = false
    @State private var isAddTeamSheetPresented = false
    @State private var isEditTeamSheetPresented = false

    @State private var isShowingRPSGame = false


    // Pull teams from SwiftData (auto-updates)
    @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]


    // Two selections
    @State private var selectedTeam1: TeamEntity?
    @State private var selectedTeam2: TeamEntity?

    // see who goes first
    @State private var isSelectedTeam1GoingFirst = false


    private let avatarSize: CGFloat = 72
    private let playerAvatarSize: CGFloat = 36

    var body: some View {
        VStack {
            HStack {
                Text("Beer Pong Scoreboard")
                    .font(.title)
                    .bold()
            }

            HStack {
                // MARK: - Team 1 Picker
                Picker("Select Team 1", selection: $selectedTeam1) {
                    Text("Team").tag(TeamEntity?.none)

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
                    Text("Team").tag(TeamEntity?.none)

                    ForEach(teams.filter { team in
                        team.id != selectedTeam1?.id
                    }) { team in
                        Text(team.name).tag(TeamEntity?.some(team))
                    }
                }
                .pickerStyle(.menu)
            }

            ScrollView(showsIndicators: false) {
                // MARK: - Matchup Summary (Vertical Stack)
                VStack(spacing: 8) {
                    if let team1 = selectedTeam1 {
                        teamSummaryView(team: team1)
                            .overlay {
                                    if isSelectedTeam1GoingFirst {
                                        Text("⚔️ Goes First!").font(.system(size: 24))
                                    }
                                }
                    } else {
                        emptyTeamSummary(label: "Team 1")
                    }

                    Text("VS.")
                        .font(.largeTitle)
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



                // MARK: - Start Game Button (No Action Yet)
                Button("Start Game") {
                    isShowingRPSGame = true
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
        }
        .padding()
        .fullScreenCover(isPresented: $isAddTeamSheetPresented) {
            AddTeamView()
        }
        .fullScreenCover(isPresented: $isEditTeamSheetPresented) {
            EditTeamView()
        }
        .ful
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
        .sheet(isPresented: $isShowRulesSheetPresented) {
            SafariView(url: URL(string: "https://www.probeersports.com/beer-pong")!)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $isShowingRPSGame) {
            if let team1 = selectedTeam1,
               let team2 = selectedTeam2 {
                RockPaperScissorsView(team1: team1, team2: team2)
            } else {
                // Fallback (shouldn’t really happen because button is disabled otherwise)
                Text("Please select two teams to play.")
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Rules") {
                    isShowRulesSheetPresented = true
                }
            }
            ToolbarItem {
                NavigationLink(destination: EditTeamView()) {
                    Text("Teams")
                }
            }
        }
    }

    // MARK: - Team Summary View (STACKED + BIG TEAM PHOTO)
    @ViewBuilder
    private func teamSummaryView(team: TeamEntity) -> some View {
        VStack(alignment: .center, spacing: 12) {

            // MARK: - Team photo (larger)
            if let data = team.photoData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize + 20, height: avatarSize + 20) // bigger
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize + 20, height: avatarSize + 20)
                    .foregroundStyle(.secondary)
                    .clipShape(Circle())
            }

            // MARK: - Team Name
            Text(team.name)
                .font(.title3)
                .bold()

            HStack {
                Text("Wins: \(team.wins)")
                Text("Losses: \(team.losses)")
            }

            // MARK: - Player Rows
            if team.players.isEmpty {
                Text("No players")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            } else {
                HStack(spacing: 24) {
                    ForEach(team.players) { player in
                        VStack(spacing: 4) {

                            // Player photo
                            if let data = player.photoData,
                               let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: playerAvatarSize + 6,
                                           height: playerAvatarSize + 6)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: playerAvatarSize + 6,
                                           height: playerAvatarSize + 6)
                                    .foregroundStyle(.secondary)
                                    .clipShape(Circle())
                            }

                            // Player name
                            Text(player.name)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
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
