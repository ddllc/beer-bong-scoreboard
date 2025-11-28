import SwiftUI
import SwiftData

struct TeamCardView: View {
    let team: TeamEntity?
    let avatarSize: CGFloat

    var body: some View {
        VStack(spacing: 8) {
            // Avatar / placeholder
            ZStack {
                Circle()
                    .fill(Color(.systemGray5))

                if let data = team?.photoData,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo")
                        .font(.system(size: avatarSize * 0.4))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(width: avatarSize, height: avatarSize)
            .clipShape(Circle())

            // Name or "Select team"
            Text(team?.name ?? "Select Team")
                .font(.title2.bold())
                .foregroundColor(team == nil ? .secondary : .primary)

            // Wins / losses (or placeholder)
            Text(team != nil
                 ? "Wins: \(team!.wins)  Losses: \(team!.losses)"
                 : "Wins: 0  Losses: 0")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(width: 180)          // <- fixed width so both sides match
        .multilineTextAlignment(.center)
    }
}
