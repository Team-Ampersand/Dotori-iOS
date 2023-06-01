import Swinject

public final class MusicAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MusicFactory.self) { _ in
            MusicFactoryImpl()
        }
    }
}
