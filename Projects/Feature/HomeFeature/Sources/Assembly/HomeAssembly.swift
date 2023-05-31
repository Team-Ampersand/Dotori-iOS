import Swinject

public final class HomeAssembly: Assembly {
    public init() { }
    public func assemble(container: Container) {
        container.register(HomeFactory.self) { _ in
            HomeFactoryImpl()
        }
    }
}
