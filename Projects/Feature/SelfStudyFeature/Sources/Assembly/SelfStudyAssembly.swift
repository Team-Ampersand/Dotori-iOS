import SelfStudyDomainInterface
import Swinject
import UserDomainInterface

public final class SelfStudyAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SelfStudyFactory.self) { resolver in
            SelfStudyFactoryImpl(
                fetchSelfStudyRankListUseCase: resolver.resolve(FetchSelfStudyRankListUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!
            )
        }
    }
}
