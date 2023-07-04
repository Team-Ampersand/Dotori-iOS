import Foundation

public protocol KeyValueStore {
    func save(key: StorableKeys, value: Any)
    func load(key: StorableKeys) -> Any?
    func load<T>(key: StorableKeys) -> T?
    func delete(key: StorableKeys)
}
