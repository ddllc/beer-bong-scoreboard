import SwiftUI

struct PhotosPickerLabelView: View {
    let hasPhoto: Bool

    var body: some View {
        HStack {
            Image(systemName: "photo")
            Text(hasPhoto ? "Change Photo" : "Pick Photo")
        }
    }
}
