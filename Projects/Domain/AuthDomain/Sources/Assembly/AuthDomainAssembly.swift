import AuthDomainInterface
import BaseDomain
import JwtStoreInterface
import KeyValueStoreInterface
import NetworkingInterface
import Swinject

public final class AuthDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        // MARK: - DataSource
        container.register(RemoteAuthDataSource.self) { resolver in
            RemoteAuthDataSourceImpl(
                networking: resolver.resolve(Networking.self)!
            )
        }
        .inObjectScope(.container)

        container.register(LocalAuthDataSource.self) { resolver in
            LocalAuthDataSourceImpl(jwtStore: resolver.resolve(JwtStore.self)!)
        }
        .inObjectScope(.container)

        // MARK: - Repository
        container.register(AuthRepository.self) { resolver in
            AuthRepositoryImpl(
                remoteAuthDataSource: resolver.resolve(RemoteAuthDataSource.self)!,
                localAuthDataSource: resolver.resolve(LocalAuthDataSource.self)!
            )
        }
        .inObjectScope(.container)

        // MARK: - UseCase
        container.register(SigninUseCase.self) { resolver in
            SigninUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }

        container.register(LoadJwtTokenUseCase.self) { resolver in
            LoadJwtTokenUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }

        container.register(CheckIsLoggedInUseCase.self) { resolver in
            CheckIsLoggedInUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }

        container.register(WithdrawalUseCase.self) { resolver in
            WithdrawalUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }
    }
}
