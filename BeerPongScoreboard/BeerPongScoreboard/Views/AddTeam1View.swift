import SwiftUI

struct AddTeam1View: View {
    @State private var team1Name = ""
    @State private var players: [PlayerModel] = []

    var body: some View {
        VStack {

            Text("Enter Team 1 Name")
            TextField("Team 1 Name", text: $team1Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            NavigationLink(destination: AddTeam2View()) {
                Label("Next", systemImage: "arrow.2.circlepath.circle")
            }
            .buttonBorderShape(.roundedRectangle(radius: 8))
            .buttonSizing(.flexible)
            .buttonStyle(.borderedProminent)
            .disabled(team1Name.isEmpty)
        }
        .padding()
    }
}

#Preview {
    AddTeam1View()
}
