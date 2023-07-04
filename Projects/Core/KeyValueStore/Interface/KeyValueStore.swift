import Foundation

public protocol KeyValueStore {
    func save(key: StorableKeys, value: Any)
    func load(key: StorableKeys) -> Any?
    func load<T>(key: StorableKeys) -> T?
    func delete(key: StorableKeys)
    @available(*, message: "Please use parameters that use key: 'StorableKeys' whenever possible")
    func save(key: String, value: Any)
    @available(*, message: "Please use parameters that use key: 'StorableKeys' whenever possible")
    func load(key: String) -> Any?
    @available(*, message: "Please use parameters that use key: 'StorableKeys' whenever possible")
    func load<T>(key: String) -> T?
    @available(*, message: "Please use parameters that use key: 'StorableKeys' whenever possible")
    func delete(key: String)
}
