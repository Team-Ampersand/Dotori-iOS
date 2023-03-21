import AuthDomainInterface
import BaseDomain
import Swinject
import JwtStoreInterface

public final class AuthDomainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        // MARK: - DataSource
        container.register(RemoteAuthDataSource.self) { resolver in
            RemoteAuthDataSourceImpl(jwtStore: resolver.resolve(JwtStore.self)!)
        }

        container.register(LocalAuthDataSource.self) { resolver in
            LocalAuthDataSourceImpl(jwtStore: resolver.resolve(JwtStore.self)!)
        }

        // MARK: - Repository
        container.register(AuthRepository.self) { resolver in
            AuthRepositoryImpl(
                remoteAuthDataSource: resolver.resolve(RemoteAuthDataSource.self)!,
                localAuthDataSource: resolver.resolve(LocalAuthDataSource.self)!
            )
        }

        // MARK: - UseCase
        container.register(SigninUseCase.self) { resolver in
            SigninUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }

        container.register(LoadJwtTokenUseCase.self) { resolver in
            LoadJwtTokenUseCaseImpl(authRepository: resolver.resolve(AuthRepository.self)!)
        }
    }
}
