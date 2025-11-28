import Foundation

class FileManagerService {
    private let filename = "saved_facts.json"

    private var fileURL: URL {
        let folder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return folder.appendingPathComponent(filename)
    }

    func saveFacts(_ facts: [String]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(facts) {
            try? data.write(to: fileURL)
        }
    }

    func loadFacts() -> [String] {
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: fileURL),
           let facts = try? decoder.decode([String].self, from: data) {
            return facts
        }
        return []
    }
}
