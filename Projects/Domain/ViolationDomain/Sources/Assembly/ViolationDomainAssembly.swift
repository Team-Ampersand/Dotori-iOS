import NetworkingInterface
import Swinject
import ViolationDomainInterface

public final class ViolationDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RemoteViolationDataSource.self) { resolver in
            RemoteViolationDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }
        .inObjectScope(.container)

        container.register(ViolationRepository.self) { resolver in
            ViolationRepositoryImpl(remoteViolationDataSource: resolver.resolve(RemoteViolationDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(FetchMyViolationListUseCase.self) { resolver in
            FetchMyViolationListUseCaseImpl(violationRepository: resolver.resolve(ViolationRepository.self)!)
        }
    }
}
