import Swinject

public final class SelfStudyAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SelfStudyFactory.self) { _ in
            SelfStudyFactoryImpl()
        }
    }
}
