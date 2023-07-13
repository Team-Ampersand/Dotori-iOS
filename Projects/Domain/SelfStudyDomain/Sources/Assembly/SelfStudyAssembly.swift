import NetworkingInterface
import SelfStudyDomainInterface
import Swinject

public final class SelfStudyAssembly: Assembly {
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
    }
}
