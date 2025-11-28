import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var savedFacts: [String] = []

    private let storage = FileManagerService()
    private let fileName = "SavedFacts.txt"

    init() {
        savedFacts = storage.loadFacts()
    }

    func addFact(_ fact: String) {
        savedFacts.append(fact)
        storage.saveFacts(savedFacts)
        saveFactsToDocuments()
    }

    private func saveFactsToDocuments() {
        guard !savedFacts.isEmpty else { return }

        let text = savedFacts.joined(separator: "\n\n")
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documents.appendingPathComponent(fileName)

        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File saved in Documents: \(fileURL.path)")
        } catch {
            print("Error: \(error)")
        }
    }

    func updateFile() {
        saveFactsToDocuments()
    }
    
    func deleteFact(at offsets: IndexSet) {
            savedFacts.remove(atOffsets: offsets)
            saveFacts()
    }
    
    private func saveFacts() {
            storage.saveFacts(savedFacts)
            saveFactsToDocuments()
        }
}
