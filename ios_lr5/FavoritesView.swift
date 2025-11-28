import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesVM: FavoritesViewModel
    @State private var showMessage = false
    @State private var messageText = ""

    var body: some View {
        VStack {
            List {
                ForEach(favoritesVM.savedFacts, id: \.self) { fact in
                    Text(fact)
                        .padding()
                }
                .onDelete(perform: deleteFact)
            }

            Button("Update file") {
                favoritesVM.updateFile()
                messageText = "File updated in Documents."
                showMessage = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Saved Facts")
        .alert(isPresented: $showMessage) {
            Alert(title: Text("Message"), message: Text(messageText), dismissButton: .default(Text("OK")))
        }
    }

    private func deleteFact(at offsets: IndexSet) {
        favoritesVM.deleteFact(at: offsets)
    }
}
