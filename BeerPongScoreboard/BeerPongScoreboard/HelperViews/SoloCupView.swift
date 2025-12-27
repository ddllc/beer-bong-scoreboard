import SwiftUI

struct SoloCupView: View {
    let style: SoloCupStyle
    let cupSize: CGFloat
    let fallDirection: FallDirection
    @Binding var isSunk: Bool

    var body: some View {
        Image(style.imageName)
            .resizable()
            .scaledToFit()
            .frame(width: cupSize, height: cupSize)
            .rotationEffect(.degrees(isSunk ? fallDirection.rotationDegrees : 0), anchor: .bottom)
            .offset(x: isSunk ? fallDirection.xOffset : 0,
                    y: isSunk ? 6 : 0)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.18)) {
                    isSunk.toggle()
                }
            }
    }

    enum SoloCupStyle: String, CaseIterable, Identifiable {
        case red
        case blue
        case redWhiteRim
        case blueWhiteRim

        var id: String { rawValue }

        var imageName: String {
            switch self {
            case .red:
                return "SoloCupRed"
            case .blue:
                return "SoloCupBlue"
            case .redWhiteRim:
                return "SoloCupRedWhiteRim"
            case .blueWhiteRim:
                return "SoloCupBlueWhiteRim"
            }
        }
    }

    enum FallDirection {
        case left
        case right

        var rotationDegrees: Double { self == .left ? -60 : 60 }
        var xOffset: CGFloat { self == .left ? -6 : 6 }
    }
}


