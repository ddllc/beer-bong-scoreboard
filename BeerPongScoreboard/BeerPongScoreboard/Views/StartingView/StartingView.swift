import SwiftUI
import SwiftData

struct StartingView: View {
    @State private var isShowRulesSheetPresented = false
    @State private var isAddTeamSheetPresented = false
    @State private var isEditTeamSheetPresented = false

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

            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Picker("Select Team 1", selection: $selectedTeam1) {
                            Text("Select Team").tag(TeamEntity?.none)

                            ForEach(teams.filter { team in
                                team.id != selectedTeam2?.id
                            }) { team in
                                Text(team.name).tag(TeamEntity?.some(team))
                            }
                        }
                        .pickerStyle(.menu)

                        if let team1 = selectedTeam1 {
                            leadingTeamSummaryView(team: team1)
                        } else {
                            HStack {
                                Spacer()
                                leadingEmptyTeamSummaryView(label: "Team 1")
                                Spacer()
                            }
                        }
                    }

                    VStack {
                        Text("VS.")
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical, 4)
                    }

                    VStack(alignment: .trailing) {
                        Picker("Pick Team 2", selection: $selectedTeam2) {
                            Text("Select Team").tag(TeamEntity?.none)

                            ForEach(teams.filter { team in
                                team.id != selectedTeam1?.id
                            }) { team in
                                Text(team.name).tag(TeamEntity?.some(team))
                            }
                        }
                        .pickerStyle(.menu)
                        if let team2 = selectedTeam2 {
                            leadingTeamSummaryView(team: team2)
                        } else {
                            HStack {
                                Spacer()
                                trailingEmptyTeamSummaryView(label: "Team 2")
                                Spacer()
                            }
                        }
                    }
                }
            }

            VStack(alignment: .trailing) {
                if let team1 = selectedTeam1,
                   let team2 = selectedTeam2 {

                    NavigationLink {
                        RockPaperScissorsView(
                            team1: team1,
                            team2: team2
                        )
                    } label: {
                        Text("Rock Paper Scissors")
                    }
                    .buttonStyle(.glassProminent)
                    .buttonSizing(.flexible)
                    .buttonBorderShape(.roundedRectangle(radius: 8))
                    .padding()

                } else {
                    // Disabled-looking button when teams not ready
                    Button("Rock Paper Scissors") {}
                        .buttonStyle(.glassProminent)
                        .buttonSizing(.flexible)
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        .padding()
                        .disabled(true)
                }
            }

            Spacer()
        }
        .navigationTitle("Beer Pong Scoreboard")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $isAddTeamSheetPresented) {
            AddTeamView()
        }
        .fullScreenCover(isPresented: $isEditTeamSheetPresented) {
            EditTeamsView()
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
        .sheet(isPresented: $isShowRulesSheetPresented) {
            SafariView(url: URL(string: "https://www.probeersports.com/beer-pong")!)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Rules") {
                    isShowRulesSheetPresented = true
                }
            }
            ToolbarItem {
                NavigationLink(destination: EditTeamsView()) {
                    Text("Edit Teams")
                }
            }
        }
    }

    // MARK: - Leading Team Summary View (STACKED + BIG TEAM PHOTO)
    @ViewBuilder
    private func leadingTeamSummaryView(team: TeamEntity) -> some View {
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

    // MARK: - Leading Empty Summary Placeholder
    @ViewBuilder
    private func leadingEmptyTeamSummaryView(label: String) -> some View {
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
        }
    }

    // MARK: - Leading Empty Summary Placeholder
    @ViewBuilder
    private func trailingEmptyTeamSummaryView(label: String) -> some View {
        HStack(spacing: 12) {

            VStack(alignment: .trailing, spacing: 4) {
                Text(label)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Text("Select a team")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Image(systemName: "photo.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
                .foregroundStyle(.secondary)

        }
    }
}

#Preview {
    NavigationStack {
        StartingView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
