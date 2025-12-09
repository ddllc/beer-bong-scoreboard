import SwiftUI

struct TeamCardView: View {
    let team: TeamEntity?
    private let avatarSize: CGFloat = 100

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))

                if let data = team?.photoData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: avatarSize * 0.4))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: avatarSize, height: avatarSize)
            .clipShape(Circle())

            Text(team?.name ?? "Select Team")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                    .lineLimit(nil)           // <-- allow unlimited lines
                    .fixedSize(horizontal: false, vertical: true) // <-- important!

            Group {
                if let team {
                    Text("Wins: \(team.wins)")
                    Text("Losses: \(team.losses)")
                } else {
                    Text("Wins: 0")
                    Text("Losses: 0")
                }
            }
            .font(.headline)
            .foregroundColor(.secondary)
        }
        .frame(width: 175)

    }
}
