import Foundation

public protocol KeyValueStore {
    func save(key: String, value: Any)
    func load(key: String) -> Any?
    func load<T>(key: String) -> T?
    func delete(key: String)
}
