import SwiftUI

struct EditTeamsRowView: View {
    let team: TeamEntity
    private let avatarSize: CGFloat = 75

    var body: some View {
        HStack {
                // MARK: - Team Column
            VStack {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))

                        if let data = team.photoData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
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

                    Text(team.name)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(width: 200)

                Spacer()
                }

            Divider()
                .frame(maxHeight: .infinity)
                .background(Color(.white).fontWeight(.heavy))

                // MARK: - Players Columns
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))

                        if let data = team.players[0].photoData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: avatarSize * 0.4))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())

                    Text(team.players[0].name)
                }


                HStack {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))

                        if let data = team.players[1].photoData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.fill")
                                .font(.system(size: avatarSize * 0.4))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())

                    Text(team.players[1].name)
                }
            }

            Spacer()
                // MARK: - Stats Column
            VStack(alignment: .trailing) {
                Text("Wins: \(team.wins)")
                Text("Losses: \(team.losses)")
            }
            .font(.title3)
            .bold()
            }
    }
}
