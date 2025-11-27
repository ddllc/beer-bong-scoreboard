import SwiftUI
import SafariServices

struct BeerPongTableView: View {
    @Environment(AppData.self) private var appData: AppData
    @State private var showingWebSheet = false

    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    VStack {
    //                    Text("\(appData.players[appData.currentTurnIndex - 1])'s Turn")
                        Text("Round \(String(appData.roundNumber))")
                    }
                    .font(.title)
                    .bold()
                    Divider()
                    HStack {
                        Text(
                            """
                            **Player 1**
                            \(String(appData.team1AmountOfSunkCups)) / 10 Cups
                            """
                        )
                        .multilineTextAlignment(.center)
                        Spacer()
                        Text(
                            """
                            **Player 2**
                            \(String(appData.team2AmountOfSunkCups)) / 10 Cups
                            """
                        )
                        .multilineTextAlignment(.center)
                    }
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)

                    Divider()
                    Spacer()

                    // Use let to derive team/turn UI
                    let isTeam1Turn = appData.currentTurnIndex == 1 || appData.currentTurnIndex == 2
                    let teamNumber = isTeam1Turn ? 1 : 2
                    let soloCupColor: SoloCupColor = isTeam1Turn ? .red : .blue

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 7, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 8, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 9, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 10, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 4, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 5, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 6, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 2, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 3, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 1, soloCupColor: soloCupColor)
                    }
                    Spacer()
                    Button("Complete Turn") {
    //                    if appData.currentTurnIndex == appData.players.count {
    //                        appData.currentTurnIndex = 1
    //                        appData.roundNumber += 1
    //                    } else {
    //                        appData.currentTurnIndex += 1
    //                    }
                    }
                    .buttonStyle(.glassProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonSizing(.flexible)
                    .padding(.horizontal, 32)
                }
                VStack {
                    VStack {
    //                    Text("\(appData.players[appData.currentTurnIndex - 1])'s Turn")
                        Text("Round \(String(appData.roundNumber))")
                    }
                    .font(.title)
                    .bold()
                    Divider()
                    HStack {
                        Text(
                            """
                            **Player 1**
                            \(String(appData.team1AmountOfSunkCups)) / 10 Cups
                            """
                        )
                        .multilineTextAlignment(.center)
                        Spacer()
                        Text(
                            """
                            **Player 2**
                            \(String(appData.team2AmountOfSunkCups)) / 10 Cups
                            """
                        )
                        .multilineTextAlignment(.center)
                    }
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)

                    Divider()
                    Spacer()

                    // Use let to derive team/turn UI
                    let isTeam1Turn = appData.currentTurnIndex == 1 || appData.currentTurnIndex == 2
                    let teamNumber = isTeam1Turn ? 1 : 2
                    let soloCupColor: SoloCupColor = isTeam1Turn ? .red : .blue

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 7, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 8, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 9, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 10, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 4, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 5, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 6, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 2, soloCupColor: soloCupColor)
                        SoloCupView(teamNumber: teamNumber, cupID: 3, soloCupColor: soloCupColor)
                    }

                    HStack(spacing: 20) {
                        SoloCupView(teamNumber: teamNumber, cupID: 1, soloCupColor: soloCupColor)
                    }
                    Spacer()
                    Button("Complete Turn") {
    //                    if appData.currentTurnIndex == appData.players.count {
    //                        appData.currentTurnIndex = 1
    //                        appData.roundNumber += 1
    //                    } else {
    //                        appData.currentTurnIndex += 1
    //                    }
                    }
                    .buttonStyle(.glassProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonSizing(.flexible)
                    .padding(.horizontal, 32)
                }
            }

            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingWebSheet = true
                    } label: {
                        Text("Rules")
                        Image(systemName: "book.closed")
                    }
                }
            }
            .sheet(isPresented: $showingWebSheet) {
                SafariView(url: URL(string: "https://www.probeersports.com/beer-pong")!)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    NavigationStack {
        BeerPongTableView()
            .environment(AppData())
    }
}
