import SwiftUI
import SwiftData
import PhotosUI

struct PlayerRowView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var player: PlayerEntity

    let size: CGFloat
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        HStack(spacing: 12) {

            PhotosPicker(selection: $photoItem, matching: .images) {
                if let data = player.photoData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)

            TextField("Player name", text: $player.name)

            Spacer()
        }
        .onChange(of: photoItem) { _, newItem in
            guard let newItem else { return }
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self) {
                    player.photoData = data
                    try? modelContext.save()
                }
            }
        }
    }
}
