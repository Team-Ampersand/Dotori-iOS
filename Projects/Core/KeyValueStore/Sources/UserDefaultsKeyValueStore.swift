import Foundation
import KeyValueStoreInterface

final class UserDefaultsKeyValueStore: KeyValueStore {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func save(key: StorableKeys, value: Any) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }

    func load(key: StorableKeys) -> Any? {
        userDefaults.value(forKey: key.rawValue)
    }

    func load<T>(key: StorableKeys) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }

    func delete(key: StorableKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
