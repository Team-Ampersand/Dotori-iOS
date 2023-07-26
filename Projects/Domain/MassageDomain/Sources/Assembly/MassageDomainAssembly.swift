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

        container.register(ApplyMassageUseCase.self) { resolver in
            ApplyMassageUseCaseImpl(massageRepository: resolver.resolve(MassageRepository.self)!)
        }

        container.register(CancelMassageUseCase.self) { resolver in
            CancelMassageUseCaseImpl(massageRepository: resolver.resolve(MassageRepository.self)!)
        }

        container.register(FetchMassageRankListUseCase.self) { resolver in
            FetchMassageRankListUseCaseImpl(massageRepository: resolver.resolve(MassageRepository.self)!)
        }
    }
}
