import SwiftUI
import SwiftData

struct WinnerSheetView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let game: GameModel

    private var isTeamOneWinner: Bool { game.winnerTeamID == game.team1.id }
    private var isTeamTwoWinner: Bool { game.winnerTeamID == game.team2.id }

    private var team1UIImage: UIImage? {
        guard let data = game.team1.photoData else { return nil }
        return UIImage(data: data)
    }

    private var team2UIImage: UIImage? {
        guard let data = game.team2.photoData else { return nil }
        return UIImage(data: data)
    }

    var body: some View {
        ScrollView {
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    trophyView
                    Spacer()

                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("\(isTeamOneWinner ? game.team1.name : game.team2.name) WINS!")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Game Duration: \(game.durationMinuteSecondString)")
                                .foregroundStyle(.secondary)
                        }

                        Divider()

                        Text("Team Stats")
                            .font(.title)
                            .bold()

                        HStack(spacing: 32) {
                            VStack {
                                Text(game.team1.name)
                                    .font(.title3)
                                    .bold()
                                Text("Total Wins: \(game.team1.wins)")
                                Text("Total Losses: \(game.team1.losses)")
                            }

                            VStack {
                                Text(game.team2.name)
                                    .font(.title3)
                                    .bold()
                                Text("Total Wins: \(game.team2.wins)")
                                Text("Total Losses: \(game.team2.losses)")
                            }
                        }
                    }

                    Spacer()
                }
                .padding()

                Spacer()

                Button(role: .confirm) {
                    endGameAndPersist()
                } label: {
                    Text("End Game")
                        .font(.title)
                        .bold()
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .buttonSizing(.flexible)
            }
        }
    }

    // MARK: - Persistence

    private func endGameAndPersist() {
        // If WinnerSheetView is showing, we *should* already know the winner.
        guard let winnerID = game.winnerTeamID else {
            // If you want: trigger an alert here.
            return
        }

        let endedAtForSave = game.endedAt ?? Date()

        do {
            // 1) Fetch or create GameEntity (upsert by id)
            let existingGame = try fetchGameEntity(id: game.id)

            let team1Entity = try fetchTeamEntity(id: game.team1.id)
            let team2Entity = try fetchTeamEntity(id: game.team2.id)

            if let existingGame {
                // Update existing
                existingGame.startedAt = game.startedAt
                existingGame.endedAt = endedAtForSave
                existingGame.team1 = team1Entity
                existingGame.team2 = team2Entity
                existingGame.team1CupsSunk = game.team1CupsSunk
                existingGame.team2CupsSunk = game.team2CupsSunk
                existingGame.startingTeamID = game.startingTeamID
                existingGame.winnerTeamID = winnerID
            } else {
                // Insert new
                let newGame = GameEntity(
                    id: game.id,
                    startedAt: game.startedAt,
                    endedAt: endedAtForSave,
                    team1: team1Entity,
                    team2: team2Entity,
                    team1CupsSunk: game.team1CupsSunk,
                    team2CupsSunk: game.team2CupsSunk,
                    startingTeamID: game.startingTeamID,
                    winnerTeamID: winnerID
                )
                modelContext.insert(newGame)
            }

            // 2) Update team cumulative stats
            applyTeamStats(
                team1: team1Entity,
                team2: team2Entity,
                winnerTeamID: winnerID,
                team1CupsSunk: game.team1CupsSunk,
                team2CupsSunk: game.team2CupsSunk
            )

            // 3) Save once
            try modelContext.save()

            // 4) Close sheet
            dismiss()
            navigationPath = NavigationPath()

        } catch {
            // If you want, add an alert. For now, at least log.
            print("❌ Failed to end game and persist: \(error)")
        }
    }

    private func fetchGameEntity(id: UUID) throws -> GameEntity? {
        let descriptor = FetchDescriptor<GameEntity>(
            predicate: #Predicate { $0.id == id }
        )
        return try modelContext.fetch(descriptor).first
    }

    private func fetchTeamEntity(id: UUID) throws -> TeamEntity {
        let descriptor = FetchDescriptor<TeamEntity>(
            predicate: #Predicate { $0.id == id }
        )

        if let team = try modelContext.fetch(descriptor).first {
            return team
        }

        // If this ever happens, it means you're playing a game with a TeamModel
        // that was never persisted as a TeamEntity.
        throw NSError(
            domain: "WinnerSheetView",
            code: 404,
            userInfo: [NSLocalizedDescriptionKey: "TeamEntity not found for id \(id)"]
        )
    }

    private func applyTeamStats(
        team1: TeamEntity,
        team2: TeamEntity,
        winnerTeamID: UUID,
        team1CupsSunk: Int,
        team2CupsSunk: Int
    ) {
        // cups sunk / allowed totals
        team1.totalCupsSunk += team1CupsSunk
        team1.totalCupsAllowed += team2CupsSunk

        team2.totalCupsSunk += team2CupsSunk
        team2.totalCupsAllowed += team1CupsSunk

        // wins / losses
        if winnerTeamID == team1.id {
            team1.wins += 1
            team2.losses += 1
        } else if winnerTeamID == team2.id {
            team2.wins += 1
            team1.losses += 1
        }
    }

    // MARK: - UI

    private var trophyView: some View {
        ZStack(alignment: .top) {
            Image(systemName: "trophy.fill")
                .foregroundStyle(.yellow)
                .font(.system(size: 200))

            VStack {
                if isTeamOneWinner {
                    if let uiImage = team1UIImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.9), lineWidth: 2))
                            .padding(.top, 20)
                    } else {
                        Text(game.team1.name)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                } else if isTeamTwoWinner {
                    if let uiImage = team2UIImage {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.9), lineWidth: 2))
                            .padding(.top, 20)
                    } else {
                        Text(game.team2.name)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }

                Spacer()

                HStack {
                    Text("\(isTeamOneWinner ? game.team1CupsSunk : game.team2CupsSunk)")
                    Text("—")
                    Text("\(isTeamOneWinner ? game.team2CupsSunk : game.team1CupsSunk)")
                }
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.bottom, 20)
            }
        }
    }
}
