import Foundation
import KeyValueStoreInterface

final class DictionaryKeyValueStore: KeyValueStore {
    private var dictionary: [String: Any] = [:]

    func save(key: StorableKeys, value: Any) {
        dictionary[key.rawValue] = value
    }

    func load(key: StorableKeys) -> Any? {
        dictionary[key.rawValue]
    }

    func load<T>(key: StorableKeys) -> T? {
        dictionary[key.rawValue] as? T
    }

    func delete(key: StorableKeys) {
        dictionary.removeValue(forKey: key.rawValue)
    }

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
