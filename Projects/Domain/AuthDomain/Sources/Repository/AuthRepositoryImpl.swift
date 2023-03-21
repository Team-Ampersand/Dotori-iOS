import AuthDomainInterface
import Combine

struct AuthRepositoryImpl: AuthRepository {
    private let remoteAuthDataSource: any RemoteAuthDataSource
    private let localAuthDataSource: any LocalAuthDataSource

    func signin(req: SigninRequestDTO) -> AnyPublisher<Void, AuthDomainError> {
        remoteAuthDataSource.signin(req: req)
    }

    func loadJwtToken() -> AnyPublisher<JwtTokenEntity, Never> {
        localAuthDataSource.loadJwtToken()
    }
}
