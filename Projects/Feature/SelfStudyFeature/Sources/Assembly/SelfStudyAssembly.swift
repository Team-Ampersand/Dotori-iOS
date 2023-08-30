import FilterSelfStudyFeatureInterface
import SelfStudyDomainInterface
import SelfStudyFeatureInterface
import Swinject
import UserDomainInterface

public final class SelfStudyAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SelfStudyFactory.self) { resolver in
            SelfStudyFactoryImpl(
                fetchSelfStudyRankListUseCase: resolver.resolve(FetchSelfStudyRankListUseCase.self)!,
                loadCurrentUserRoleUseCase: resolver.resolve(LoadCurrentUserRoleUseCase.self)!,
                checkSelfStudyMemberUseCase: resolver.resolve(CheckSelfStudyMemberUseCase.self)!,
                filterSelfStudyFactory: resolver.resolve(FilterSelfStudyFactory.self)!
            )
        }
    }
}
