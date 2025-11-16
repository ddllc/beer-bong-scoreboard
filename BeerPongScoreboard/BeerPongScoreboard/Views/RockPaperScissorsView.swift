import SwiftUI
import ClockKit

struct RockPaperScissorsView: View {
    @State private var currentStep = 0
    private let steps = ["Rock", "Paper", "Scissors", "Shoot!"]
    private let images: [ImageResource] = [.rock, .paper, .scissors, .rockPaperScissors]
    private let cadence: TimeInterval = 1.5
    @State private var timer: Timer?
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Text(steps[currentStep])
                .font(.largeTitle)
                .bold()
                .frame(height: 60)
                .animation(.easeInOut, value: currentStep)

            // Show the correct image for the current step
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
            }
        }
    }
}

#Preview {
    RockPaperScissorsView()
}
