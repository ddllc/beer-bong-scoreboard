import SwiftUI
import SafariServices

struct BeerPongTableView: View {
    @State private var currentTurnIndex = 1
    @State private var roundNumber = 1
    @State private var team1AmountOfSunkCups = 0
    @State private var team2AmountOfSunkCups = 0
    @State private var showingWebSheet = false
    @State private var players = ["Player 1", "Player 2", "Player 3", "Player 4"]
    
    private var isTeam1Turn: Bool {
        if currentTurnIndex > 4 {
            currentTurnIndex = 1
        }
        return currentTurnIndex == 1 || currentTurnIndex == 2
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("\(players[currentTurnIndex - 1])'s Turn")
                    Text("Round \(String(roundNumber))")
                }
                .font(.title)
                .bold()
                Divider()
                HStack {
                    
                    Text(
                        """
                        **Player 1**
                        \(String(team1AmountOfSunkCups)) / 10 Cups
                        """
                        )
                    .multilineTextAlignment(.center)
                    Spacer()
                    Text(
                        """
                        **Player 2**
                        \(String(team2AmountOfSunkCups)) / 10 Cups
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
                    SoloCupView(soloCupNumber: 7, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 8, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 9, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 10, soloCupColor: isTeam1Turn ? .red : .blue)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(soloCupNumber: 4, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 5, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 6, soloCupColor: isTeam1Turn ? .red : .blue)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(soloCupNumber: 2, soloCupColor: isTeam1Turn ? .red : .blue)
                    SoloCupView(soloCupNumber: 3, soloCupColor: isTeam1Turn ? .red : .blue)
                }
                
                HStack(spacing: 20) {
                    SoloCupView(soloCupNumber: 1, soloCupColor: isTeam1Turn ? .red : .blue)
                }
                Spacer()
                Button("Complete Turn") {
                    if currentTurnIndex == players.count {
                        currentTurnIndex = 1
                        roundNumber += 1
                    } else {
                        currentTurnIndex += 1
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
    }
}

