import SwiftUI

struct LoadingView: View {
    let loadingMessage: String
    var body: some View {
        VStack {
            Text(loadingMessage)
            ProgressView()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    LoadingView(loadingMessage: "Setting up game...")
}
