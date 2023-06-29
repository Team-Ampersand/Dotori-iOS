import Foundation
import KeyValueStoreInterface

final class UserDefaultsKeyValueStore: KeyValueStore {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func save(key: String, value: Any) {
        userDefaults.setValue(value, forKey: key)
    }

    func load(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }

    func load<T>(key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }

    func delete(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
