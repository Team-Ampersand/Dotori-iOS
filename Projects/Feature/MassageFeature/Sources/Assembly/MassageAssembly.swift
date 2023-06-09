import Swinject

public final class MassageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MassageFactory.self) { _ in
            MassageFactoryImpl()
        }
    }
}
