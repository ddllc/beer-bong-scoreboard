import SwiftUI

struct BeerPongTableView: View {
    @State private var playerOneSunk: [Bool] = Array(repeating: false, count: 10)
    @State private var playerTwoSunk: [Bool] = Array(repeating: false, count: 10)

    private enum Player: String, CaseIterable { case one = "Player 1", two = "Player 2" }
    @State private var currentPlayer: Player = .one
    @State private var showResetAlert = false
    
    @State private var totalTurns = 0
    @State private var playerOneTurns = 0
    @State private var playerTwoTurns = 0

    private func bindingForCup(_ number: Int) -> Binding<Bool> {
        let index = max(1, min(10, number)) - 1
        switch currentPlayer {
        case .one:
            return Binding(
                get: { playerOneSunk[index] },
                set: { playerOneSunk[index] = $0 }
            )
        case .two:
            return Binding(
                get: { playerTwoSunk[index] },
                set: { playerTwoSunk[index] = $0 }
            )
        }
    }

    private var sunkCount: Int {
        switch currentPlayer {
        case .one: return playerOneSunk.filter { $0 }.count
        case .two: return playerTwoSunk.filter { $0 }.count
        }
    }

    private func resetGame() {
        playerOneSunk = Array(repeating: false, count: 10)
        playerTwoSunk = Array(repeating: false, count: 10)
        currentPlayer = .one
        totalTurns = 0
        playerOneTurns = 0
        playerTwoTurns = 0
    }

    private func completeTurn() {
        switch currentPlayer {
        case .one:
            playerOneTurns += 1
            currentPlayer = .two
        case .two:
            playerTwoTurns += 1
            currentPlayer = .one
        }
        totalTurns += 1
    }

    private var currentRound: Int {
        max(1, (totalTurns / 2) + 1)
    }
    
    private var winnerText: String? {
        if playerOneSunk.allSatisfy({ $0 }) {
            return "Player 1 Wins! 🎉"
        } else if playerTwoSunk.allSatisfy({ $0 }) {
            return "Player 2 Wins! 🎉"
        } else {
            return nil
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 12) {
                Text("Beer Pong")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                if let winnerText {
                    Text(winnerText)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.green)
                }
                Text("\(sunkCount)/10 Cups Sunk")
                    .font(.system(size: 36, weight: .bold))
                ProgressView(value: Double(sunkCount), total: 10)
                    .tint(.red)
                    .padding(.horizontal)
                
                Text("Turn: \(currentPlayer.rawValue)")
                    .font(.headline)
                
                Text("Round \(currentRound)  ·  Turns — P1: \(playerOneTurns) · P2: \(playerTwoTurns)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Button {
                    completeTurn()
                } label: {
                    Label("Complete Turn", systemImage: "arrow.right.circle.fill")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .disabled(winnerText != nil)
                
                Text("P1: \((playerOneSunk.filter { $0 }.count))/10  ·  P2: \((playerTwoSunk.filter { $0 }.count))/10")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(Color.secondary.opacity(0.15))
            )
            .padding(.horizontal)
            .padding(.bottom)
            
            HStack {
                CupButton(soloCupNumber: 7, isSunk: bindingForCup(7))
                CupButton(soloCupNumber: 8, isSunk: bindingForCup(8))
                CupButton(soloCupNumber: 9, isSunk: bindingForCup(9))
                CupButton(soloCupNumber: 10, isSunk: bindingForCup(10))
            }
            
            HStack {
                CupButton(soloCupNumber: 4, isSunk: bindingForCup(4))
                CupButton(soloCupNumber: 5, isSunk: bindingForCup(5))
                CupButton(soloCupNumber: 6, isSunk: bindingForCup(6))
            }
            
            HStack {
                CupButton(soloCupNumber: 2, isSunk: bindingForCup(2))
                CupButton(soloCupNumber: 3, isSunk: bindingForCup(3))
            }
            
            HStack {
                CupButton(soloCupNumber: 1, isSunk: bindingForCup(1))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    showResetAlert = true
                } label: {
                    Label("Restart Game", systemImage: "trash")
                }
            }
        }
        .alert("Restart Game?", isPresented: $showResetAlert) {
            Button("Restart", role: .destructive) {
                resetGame()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will clear all sunk cups for both players and reset the game.")
        }
    }
}

#Preview {
    NavigationStack {
        BeerPongTableView()
    }
}
