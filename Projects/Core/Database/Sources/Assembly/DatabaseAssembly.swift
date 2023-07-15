import DatabaseInterface
import Swinject

public final class DatabaseAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(LocalDatabase.self) { _ in
            GRDBLocalDatabase { _ in }
        }
    }
}
