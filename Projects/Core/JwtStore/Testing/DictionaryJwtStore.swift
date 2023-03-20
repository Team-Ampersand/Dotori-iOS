import JwtStoreInterface

final class DictionaryJwtStore: JwtStore {
    private var dictionary = [String: String]()

    func save(property: JwtStoreProperties, value: String) {
        dictionary[property.rawValue] = value
    }

    func load(property: JwtStoreProperties) -> String {
        dictionary[property.rawValue] ?? ""
    }

    func delete(property: JwtStoreProperties) {
        dictionary.removeValue(forKey: property.rawValue)
    }
}
