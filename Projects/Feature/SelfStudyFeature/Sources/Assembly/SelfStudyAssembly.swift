import SelfStudyDomainInterface
import Swinject

public final class SelfStudyAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(SelfStudyFactory.self) { resolver in
            SelfStudyFactoryImpl(
                fetchSelfStudyRankListUseCase: resolver.resolve(FetchSelfStudyRankListUseCase.self)!
            )
        }
    }
}
