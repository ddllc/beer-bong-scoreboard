import SwiftUI
import SwiftData

struct StartingView: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Query(sort: \TeamEntity.name) private var teams: [TeamEntity]
    @State private var isShowRulesSheetPresented = false
    @State private var selectedTeam1: TeamEntity?
    @State private var selectedTeam2: TeamEntity?

    private var availableTeamsForTeam1: [TeamEntity] {
        teams.filter { $0.id != selectedTeam2?.id }
    }

    private var availableTeamsForTeam2: [TeamEntity] {
        teams.filter { $0.id != selectedTeam1?.id }
    }

    private var canStartGame: Bool {
        selectedTeam1 != nil && selectedTeam2 != nil
    }

    private var currentGame: GameModel? {
        guard let team1 = selectedTeam1,
              let team2 = selectedTeam2 else {
            return nil
        }

        return GameModel(
            id: UUID(),
            startedAt: Date(),
            endedAt: nil,
            team1: team1.toModel(),
            team2: team2.toModel(),
            team1CupsSunk: 0,
            team2CupsSunk: 0,
            startingTeamID: team1.id,   // or team2.id after RPS
            winnerTeamID: nil
        )
    }


    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // MARK: - Matchup Row
                    HStack(alignment: .lastTextBaseline) {
                        // MARK: Matchup Left Column
                        HStack(alignment: .lastTextBaseline) {
                            VStack {
                                Image("SoloCupBlue")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.85)
                            }

                            VStack {
                                Picker("Select Team 1", selection: $selectedTeam1) {
                                    Text("Select Team")
                                        .tag(nil as TeamEntity?)
                                    ForEach(availableTeamsForTeam1) { team in
                                        Text(team.name).tag(team as TeamEntity?)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.soloCupBlue)

                                TeamCardView(team: selectedTeam1)

                            }
                            .padding(4)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 22, style: .continuous)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .stroke(.white.opacity(0.15), lineWidth: 1)
                            )
                        }

                        // MARK: Matchup Center Column
                        VStack {
                            Spacer()
                            Text("VS")
                                .font(.system(size: 75))
                                .fontWeight(.heavy)
                            Spacer()
                        }

                        // MARK: Matchup Right Column
                        HStack(alignment: .lastTextBaseline) {
                            VStack {
                                Picker("Select Team 2", selection: $selectedTeam2) {
                                    Text("Select Team")
                                        .tag(nil as TeamEntity?)

                                    ForEach(availableTeamsForTeam2) { team in
                                        Text(team.name).tag(team as TeamEntity?)
                                    }
                                }
                                .pickerStyle(.menu)
                                .tint(.soloCupRed)

                                TeamCardView(team: selectedTeam2)
                            }
                            .padding(4)
                            .background(
                                .ultraThinMaterial,
                                in: RoundedRectangle(cornerRadius: 22, style: .continuous)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 22, style: .continuous)
                                    .stroke(.white.opacity(0.15), lineWidth: 1)
                            )

                            VStack {
                                Image("SoloCupRed")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.85)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)

                    // MARK: - Start Button
                    HStack {
                        if let game = currentGame {
                            NavigationLink {
                                GameView(game: game)
                            } label: {
                                Text("Start Game")
                                    .font(.title2)
                                    .bold()
                            }
                            .frame(maxWidth: 300)
                            .buttonStyle(.glassProminent)
                            .buttonSizing(.flexible)
                            .buttonBorderShape(.roundedRectangle(radius: 8))
                        } else {
                            Button {
                                // no-op
                            } label: {
                                Text("Start Game")
                                    .font(.title2)
                                    .bold()
                            }
                            .frame(maxWidth: 300)
                            .buttonStyle(.glassProminent)
                            .buttonSizing(.flexible)
                            .buttonBorderShape(.roundedRectangle(radius: 8))
                            .disabled(true)
                        }
                    }


                }
            }
        .onChange(of: dynamicTypeSize) { _, newSize in
            print("Dynamic type size changed to: \(newSize)")
        }
        .navigationTitle("Beer Pong Scoreboard")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowRulesSheetPresented) {
            // MARK: Web Sheet Rules
            // SafariView(url: URL(string: "https://www.probeersports.com/beer-pong")!)
            // .ignoresSafeArea()
            
            RulesView()
        }
        // MARK: Settings Rules
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Rules") {
                    isShowRulesSheetPresented = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
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
