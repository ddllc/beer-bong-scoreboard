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

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {

                    // MARK: - Pickers + Team Cards
                    HStack(alignment: .top) {
                        // LEFT SIDE
                        VStack(alignment: .leading, spacing: 8) {
                            Picker("Select Team 1", selection: $selectedTeam1) {
                                Text("Select Team").tag(TeamEntity?.none)

                                ForEach(teams.filter { team in
                                    team.id != selectedTeam2?.id
                                }) { team in
                                    Text(team.name).tag(TeamEntity?.some(team))
                                }
                            }
                            .pickerStyle(.menu)

                            TeamCardView(team: selectedTeam1,
                                         avatarSize: avatarSize + 20)
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                        }

                        // CENTER "VS."
                        VStack {
                            Spacer()
                            Text("VS")
                                .font(.system(size: 75, weight: .heavy))
                                .padding(.vertical, 4)
                            Spacer()
                        }
                        .frame(minWidth: 40)

                        // RIGHT SIDE
                        VStack(alignment: .trailing, spacing: 8) {
                            Picker("Pick Team 2", selection: $selectedTeam2) {
                                Text("Select Team").tag(TeamEntity?.none)

                                ForEach(teams.filter { team in
                                    team.id != selectedTeam1?.id
                                }) { team in
                                    Text(team.name).tag(TeamEntity?.some(team))
                                }
                            }
                            .pickerStyle(.menu)

                            TeamCardView(team: selectedTeam2,
                                         avatarSize: avatarSize + 20)
                                .frame(maxWidth: .infinity,
                                       alignment: .trailing)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
            }

            // MARK: - Rock Paper Scissors Button
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
}

#Preview {
    NavigationStack {
        StartingView()
            .modelContainer(for: [TeamEntity.self, PlayerEntity.self], inMemory: true)
    }
}
