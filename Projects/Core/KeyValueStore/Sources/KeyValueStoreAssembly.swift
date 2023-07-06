import Foundation
import KeyValueStoreInterface
import Swinject

public final class KeyValueStoreAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeyValueStore.self) { _ in
            UserDefaultsKeyValueStore(userDefaults: .standard)
        }
        .inObjectScope(.container)
    }
}
