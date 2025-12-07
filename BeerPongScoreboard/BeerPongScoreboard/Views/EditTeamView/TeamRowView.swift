import SwiftUI

struct EditTeamsRowView: View {
    let team: TeamEntity

    var body: some View {
        HStack {
            
            if let teamPhoto = team.photoData {
                Image(uiImage: UIImage(data: teamPhoto)!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)

            } else {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)

            }

            Text(team.name)

            Text(team.players[0].name)

            Text(team.players[1].name)

        }
    }
}
