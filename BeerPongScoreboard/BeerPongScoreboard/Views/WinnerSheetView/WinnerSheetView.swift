import SwiftUI

struct WinnerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    let winningTeamName: String
    let scoreLine: String
    let durationText: String

    var body: some View {
        NavigationStack {
            VStack {

                // MARK: - Celebration
                Image(systemName: "trophy.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(.yellow)

                Text("\(winningTeamName) Win!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text(scoreLine)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .monospacedDigit()

                Text("Duration: \(durationText)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Spacer()

                // MARK: - End Game Button
                VStack {
                    Button(role: .confirm) {

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
            .padding()
            .toolbar {
                Button("Go Back", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}
