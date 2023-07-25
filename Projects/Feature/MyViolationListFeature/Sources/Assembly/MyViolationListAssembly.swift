import Swinject
import ViolationDomainInterface

public final class MyViolationListAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MyViolationListFactory.self) { resolver in
            MyViolationListFactoryImpl(
                fetchMyViolationListUseCase: resolver.resolve(FetchMyViolationListUseCase.self)!
            )
        }
    }
}
