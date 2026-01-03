import SwiftUI

struct RulesView: View {
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss
    @State private var isRerackEnabled = false
    @State private var isTurnIndicatorEnabled = false

    var body: some View {
        NavigationStack {
            Form {

                // MARK: - Re-Rack Options
                Section("Re-Rack Options") {

                    Toggle("Allow Re-Rack", isOn: $isRerackEnabled)
                }

                // MARK: - Turn Indicator
                Section("Turn Indicator") {
                    Toggle("Show Turn Indicator", isOn: $isTurnIndicatorEnabled)
                }
            }
            .navigationTitle("Game Rules")
            .toolbar {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }

                Button("Save", role: .confirm) {
                    appData.isRerackEnabled = isRerackEnabled
                    appData.isTurnIndicatorEnabled = isTurnIndicatorEnabled
                    dismiss()
                }
            }
        }
    }
}
