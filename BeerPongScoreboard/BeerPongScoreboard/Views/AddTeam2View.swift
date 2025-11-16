import SwiftUI

struct AddTeam2View: View {
    @State private var team2Name = ""
    @State private var players: [PlayerModel] = []

    var body: some View {
        VStack {

            Text("Enter Team 1 Name")
            TextField("Team 1 Name", text: $team2Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            NavigationLink(destination: RockPaperScissorsView()) {
                Label("Next", systemImage: "arrow.2.circlepath.circle")
            }
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .buttonSizing(.flexible)
            .buttonStyle(.borderedProminent)
            .disabled(team2Name.isEmpty)
        }
        .padding()
    }
}

#Preview {
    AddTeam2View()
}
