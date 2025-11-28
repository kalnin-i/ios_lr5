import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesVM: FavoritesViewModel

    var body: some View {
        List {
            ForEach(favoritesVM.savedFacts, id: \.self) { fact in
                Text(fact)
                    .padding()
            }
        }
        .navigationTitle("Saved Facts")
    }
}
