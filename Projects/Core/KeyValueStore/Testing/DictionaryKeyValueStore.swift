import Foundation
import KeyValueStoreInterface

final class DictionaryKeyValueStore: KeyValueStore {
    private var dictionary: [String: Any] = [:]

    func save(key: String, value: Any) {
        dictionary[key] = value
    }

    func load(key: String) -> Any? {
        dictionary[key]
    }

    func load<T>(key: String) -> T? {
        dictionary[key] as? T
    }

    func delete(key: String) {
        dictionary.removeValue(forKey: key)
    }
}
