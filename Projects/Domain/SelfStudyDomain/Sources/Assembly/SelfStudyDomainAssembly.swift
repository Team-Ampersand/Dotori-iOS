import NetworkingInterface
import SelfStudyDomainInterface
import Swinject

public final class SelfStudyDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RemoteSelfStudyDataSource.self) { resolver in
            RemoteSelfStudyDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }
        .inObjectScope(.container)

        container.register(SelfStudyRepository.self) { resolver in
            SelfStudyRepositoryImpl(remoteSelfStudyDataSource: resolver.resolve(RemoteSelfStudyDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(FetchSelfStudyInfoUseCase.self) { resolver in
            FetchSelfStudyInfoUseCaseImpl(selfStudyRepository: resolver.resolve(SelfStudyRepository.self)!)
        }

        container.register(ApplySelfStudyUseCase.self) { resolver in
            ApplySelfStudyUseCaseImpl(selfStudyRepository: resolver.resolve(SelfStudyRepository.self)!)
        }

        container.register(FetchSelfStudyRankListUseCase.self) { resolver in
            FetchSelfStudyRankListUseCaseImpl(selfStudyRepository: resolver.resolve(SelfStudyRepository.self)!)
        }

        container.register(CheckSelfStudyMemberUseCase.self) { resolver in
            CheckSelfStudyMemberUseCaseImpl(selfStudyRepository: resolver.resolve(SelfStudyRepository.self)!)
        }
    }
}
