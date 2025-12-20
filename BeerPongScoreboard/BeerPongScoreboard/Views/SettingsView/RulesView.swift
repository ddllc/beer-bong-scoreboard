import SwiftUI

struct RulesView: View {
    @Environment(AppData.self) private var appData
    @Environment(\.dismiss) private var dismiss

    @State private var isRerackEnabled = false
    @State private var isOneRerackEnabled = false
    @State private var isTwoReracksEnabled = false

    @State private var isTurnIndicatorEnabled = false

    var body: some View {
        NavigationStack {
            Form {

                // MARK: - Re-Rack Options
                Section("Re-Rack Options") {

                    Toggle("Allow Re-Rack", isOn: $isRerackEnabled)

                    if isRerackEnabled {

                        Toggle("One Re-Rack (6 cups)", isOn: $isOneRerackEnabled)
                            .onChange(of: isOneRerackEnabled) { _, newValue in
                                if newValue {
                                    isTwoReracksEnabled = false
                                }
                            }

                        Toggle("Two Re-Racks (6 cups and 3 cups)", isOn: $isTwoReracksEnabled)
                            .onChange(of: isTwoReracksEnabled) { _, newValue in
                                if newValue {
                                    isOneRerackEnabled = false
                                }
                            }
                    }
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
                    appData.isOneRerackEnabled = isOneRerackEnabled
                    appData.isTwoReracksEnabled = isTwoReracksEnabled
                    appData.isTurnIndicatorEnabled = isTurnIndicatorEnabled
                    dismiss()
                }
            }
        }
    }
}
