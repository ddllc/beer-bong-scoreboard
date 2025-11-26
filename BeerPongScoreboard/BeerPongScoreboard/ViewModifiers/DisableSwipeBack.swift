import SwiftUI

struct DisableSwipeBackModifier: ViewModifier {
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content
            .background(SwipeBackController(isEnabled: isEnabled))
    }

    private struct SwipeBackController: UIViewControllerRepresentable {
        let isEnabled: Bool

        func makeUIViewController(context: Context) -> UIViewController {
            Controller(isEnabled: isEnabled)
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            (uiViewController as? Controller)?.isEnabled = isEnabled
        }

        private final class Controller: UIViewController {
            var isEnabled: Bool {
                didSet { update() }
            }

            init(isEnabled: Bool) {
                self.isEnabled = isEnabled
                super.init(nibName: nil, bundle: nil)
            }

            required init?(coder: NSCoder) { fatalError() }

            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                update()
            }

            private func update() {
                navigationController?.interactivePopGestureRecognizer?.isEnabled = isEnabled
            }
        }
    }
}
