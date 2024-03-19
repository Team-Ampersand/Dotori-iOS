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

        container.register(RemoteHomeDataSource.self) { resolver in
            RemoteHomeDataSourceImpl(networking: resolver.resolve(Networking.self)!)
        }

        container.register(UserRepository.self) { resolver in
            UserRepositoryImpl(
                localUserDataSource: resolver.resolve(LocalUserDataSource.self)!,
                remoteUserDataSource: resolver.resolve(RemoteUserDataSource.self)!,
                remoteHomeDataSource: resolver.resolve(RemoteHomeDataSource.self)!
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

        container.register(AddProfileImageUseCase.self) { resolver in
            AddProfileImageUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }

        container.register(DeleteProfileImageUseCase.self) { resolver in
            DeleteProfileImageUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }

        container.register(FetchProfileImageUseCase.self) { resolver in
            FetchProfileImageUseCaseImpl(userRepository: resolver.resolve(UserRepository.self)!)
        }
    }
}
