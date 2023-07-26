import MassageDomainInterface
import Swinject
import UserDomainInterface

public final class MassageAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MassageFactory.self) { resolver in
            MassageFactoryImpl(
                fetchMassageRankListUseCase: resolver.resolve(FetchMassageRankListUseCase.self)!
            )
        }
    }
}
