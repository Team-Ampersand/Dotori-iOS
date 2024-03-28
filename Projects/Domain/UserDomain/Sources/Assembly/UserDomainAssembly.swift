import JwtStoreInterface
import KeyValueStoreInterface
import NetworkingInterface
import Swinject
import UserDomainInterface

public final class UserDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(LocalUserDataSource.self) { resolver in
            LocalUserDataSourceImpl(
                keyValueStore: resolver.resolve(KeyValueStore.self)!,
                jwtStore: resolver.resolve(JwtStore.self)!
            )
        }
        .inObjectScope(.container)

        container.register(RemoteUserDataSource.self) { resolver in
            RemoteUserDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }

        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(
                localUserDataSource: resolver.resolve(LocalUserDataSource.self)!,
                remoteUserDataSource: resolver.resolve(RemoteUserDataSource.self)!
            )
        }
        .inObjectScope(.container)

        container.register(LoadCurrentUserRoleUseCase.self) { resolver in
            LoadCurrentUserRoleUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }

        container.register(LogoutUseCase.self) { resolver in
            LogoutUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }

        container.register(WithdrawalUseCase.self) { resolver in
            WithdrawalUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }
    }
}