import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .frame(width: 200, height: 200)
    }
}

#Preview {
    LoadingView()
}
