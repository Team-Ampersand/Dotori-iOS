import Swinject

public final class NoticeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NoticeFactory.self) { _ in
            NoticeFactoryImpl()
        }
    }
}
