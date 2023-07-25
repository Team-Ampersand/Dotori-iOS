import Swinject

public final class MyViolationListAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MyViolationListFactory.self) { _ in
            MyViolationListFactoryImpl()
        }
    }
}
