import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsVM: SettingsViewModel

    var body: some View {
        Form {
            Section(header: Text("Font Size")) {
                Slider(value: $settingsVM.settings.fontSize, in: 14...30, step: 1)
                Text("Preview text")
                    .font(.system(size: settingsVM.settings.fontSize))
            }

            Section(header: Text("Button Color")) {
                Picker("Color", selection: $settingsVM.settings.buttonColor) {
                    Text("Green").tag("green")
                    Text("Red").tag("red")
                    Text("Blue").tag("blue")
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Settings")
    }
}
