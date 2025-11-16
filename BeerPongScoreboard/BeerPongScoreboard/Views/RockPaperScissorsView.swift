import SwiftUI
import ClockKit

struct RockPaperScissorsView: View {
    @State private var currentStep = 0
    private let steps = ["Rock", "Paper", "Scissors", "Shoot!"]
    private let images: [ImageResource] = [.rock, .paper, .scissors, .rockPaperScissors]
    private let cadence: TimeInterval = 1.5
    @State private var timer: Timer?
    @State private var isAnimating = false
    @State private var isWhoWonAlertPresented = false

    var body: some View {
        VStack {
            Text(steps[currentStep])
                .font(.largeTitle)
                .bold()
                .frame(height: 60)
                .animation(.easeInOut, value: currentStep)

            Image(images[currentStep])
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .animation(.easeInOut, value: currentStep)

            Button {
                startSequence()
            } label: {
                Text("Play Game")
                    .font(.title)
                    .bold()
            }
            .buttonSizing(.flexible)
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .buttonStyle(.glassProminent)
            .disabled(isAnimating)
        }
        .padding()
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
        .alert("Who Won?", isPresented: $isWhoWonAlertPresented) {
            Button("Team 1") {
                // TODO: handle Team 1 winning (e.g., update AppData or navigate)
            }
            Button("Team 2") {
                // TODO: handle Team 2 winning (e.g., update AppData or navigate)
            }
            Button("Redo", role: .cancel) {
                // Restart the sequence
                startSequence()
            }
        } message: {
            Text("Select the winner or redo the round.")
        }
    }

    private func startSequence() {
        guard !isAnimating else { return }
        isAnimating = true
        currentStep = 0

        var step = 0
        timer = Timer.scheduledTimer(withTimeInterval: cadence, repeats: true) { currentTimer in
            step += 1
            if step < steps.count {
                currentStep = step
            } else {
                currentTimer.invalidate()
                timer = nil
                isAnimating = false
                // Present the winner alert when the sequence finishes
                isWhoWonAlertPresented = true
            }
        }
    }
}

#Preview {
    RockPaperScissorsView()
}
