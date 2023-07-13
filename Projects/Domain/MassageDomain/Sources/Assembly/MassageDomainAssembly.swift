import MassageDomainInterface
import NetworkingInterface
import Swinject

public final class MassageDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(RemoteMassageDataSource.self) { resolver in
            RemoteMassageDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }
        .inObjectScope(.container)

        container.register(MassageRepository.self) { resolver in
            MassageRepositoryImpl(remoteMassageDataSource: resolver.resolve(RemoteMassageDataSource.self)!)
        }
        .inObjectScope(.container)

        container.register(FetchMassageInfoUseCase.self) { resolver in
            FetchMassageInfoUseCaseImpl(massageRepository: resolver.resolve(MassageRepository.self)!)
        }
    }
}
