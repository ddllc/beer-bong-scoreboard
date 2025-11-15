import SwiftUI

struct CupButton: View {
    let soloCupNumber: Int
    @Binding var isSunk: Bool
    
    var body: some View {
        Button {
            isSunk.toggle()
        } label: {
            ZStack {
                SoloCupView(soloCupNumber: soloCupNumber)
                    .rotationEffect(isSunk ? Angle(degrees: -35) : .zero, anchor: .center)
                    .offset(x: isSunk ? -8 : 0, y: isSunk ? 10 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSunk)
                Image(systemName: "xmark")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.red)
                    .opacity(isSunk ? 1 : 0)
                    .rotationEffect(isSunk ? Angle(degrees: -35) : .zero, anchor: .center)
                    .offset(x: isSunk ? -8 : 0, y: isSunk ? 10 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isSunk)
            }
        }
    }
}

private struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview("CupButton") {
    StatefulPreviewWrapper(false) { isSunk in
        CupButton(soloCupNumber: 9, isSunk: isSunk)
    }
}
