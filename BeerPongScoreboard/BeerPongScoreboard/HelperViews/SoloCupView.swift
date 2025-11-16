import SwiftUI

struct SoloCupView: View {
    @Binding var appData: AppData
    let soloCupNumber: Int
    let soloCupColor: SoloCupColor
    @State private var isSunk = false
    
    var body: some View {
        Button {
            isSunk.toggle()
        } label: {
            Image(soloCupColor == .red ? "SoloCupRed" : "SoloCupBlue")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .rotationEffect(isSunk ? Angle(degrees: -90) : .zero)
        }
                   
    }
}

#Preview("SoloCupRed") {
    SoloCupView(appData: .constant(AppData()), soloCupNumber: 1, soloCupColor: .red)
}

#Preview("SoloCupBlue") {
    SoloCupView(appData: .constant(AppData()), soloCupNumber: 1, soloCupColor: .blue)
}

enum SoloCupColor: String {
    case red
    case blue
}
