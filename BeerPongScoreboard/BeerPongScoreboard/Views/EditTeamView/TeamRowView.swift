import SwiftUI

struct TeamRowView: View {
    let team: TeamEntity
    private let avatarSize: CGFloat = 44

    var body: some View {
        HStack(spacing: 12) {
            if let data = team.photoData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(team.name)
                    .font(.headline)

                Text("\(team.players.count) player\(team.players.count == 1 ? "" : "s")")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("W \(team.wins)")
                Text("L \(team.losses)")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}
