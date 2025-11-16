import SwiftUI
import SafariServices

struct BeerPongTableView: View {
    @Environment(AppData.self) private var appData: AppData

    @State private var showingWebSheet = false

    private var isTeam1Turn: Bool {
        if appData.currentTurnIndex > 4 {
            appData.currentTurnIndex = 1
        }
        return appData.currentTurnIndex == 1 || appData.currentTurnIndex == 2
    }
    
    private var currentTeamNumber: Int {
        isTeam1Turn ? 1 : 2
    }
    private var currentSoloCupColor: SoloCupColor {
        isTeam1Turn ? .red : .blue
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("\(appData.players[appData.currentTurnIndex - 1])'s Turn")
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
                HStack(spacing: 20) {
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 7, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 8, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 9, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 10, soloCupColor: currentSoloCupColor)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 4, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 5, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 6, soloCupColor: currentSoloCupColor)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 2, soloCupColor: currentSoloCupColor)
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 3, soloCupColor: currentSoloCupColor)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(teamNumber: currentTeamNumber, cupID: 1, soloCupColor: currentSoloCupColor)
                }
                Spacer()
                Button("Complete Turn") {
                    if appData.currentTurnIndex == appData.players.count {
                        appData.currentTurnIndex = 1
                        appData.roundNumber += 1
                    } else {
                        appData.currentTurnIndex += 1
                    }
                }
                .buttonStyle(.glassProminent)
                .buttonBorderShape(.roundedRectangle)
                .buttonSizing(.flexible)
                .padding(.horizontal, 32)
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
