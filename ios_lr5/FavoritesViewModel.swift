import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var savedFacts: [String] = []

    private let storage = FileManagerService()

    init() {
        savedFacts = storage.loadFacts()
    }

    func addFact(_ fact: String) {
        savedFacts.append(fact)
        storage.saveFacts(savedFacts)
    }
}
