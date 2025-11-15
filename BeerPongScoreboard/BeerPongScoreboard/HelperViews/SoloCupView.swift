import SwiftUI

struct SoloCupView: View {
    let soloCupNumber: Int
    var body: some View {
        Image("SoloCup")
            .resizable()
            .scaledToFit()
            .frame(width: 75)
    }
}

#Preview {
    SoloCupView(soloCupNumber: 1)
}
