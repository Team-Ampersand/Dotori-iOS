import JwtStoreInterface
import Swinject

public final class JwtStoreAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(JwtStore.self) { _ in
            KeychainJwtStore()
        }.inObjectScope(.container)
    }
}
