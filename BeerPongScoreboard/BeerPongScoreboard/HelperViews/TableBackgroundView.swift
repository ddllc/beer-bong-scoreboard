import SwiftUI

struct TableBackgroundView: View {

    var body: some View {
        ZStack {
            // Table color
            Color.tableBackground
//                .ignoresSafeArea()

            // Center line (horizontal for landscape)
            Rectangle()
                .fill(Color.tableBackground)
        }
    }
}
