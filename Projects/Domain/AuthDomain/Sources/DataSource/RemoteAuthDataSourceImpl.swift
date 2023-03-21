import AuthDomainInterface
import BaseDomain
import Combine

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthEndpoint>, RemoteAuthDataSource {
    func signin(req: SigninRequestDTO) -> AnyPublisher<Void, AuthDomainError> {
        request(.signin(req))
            .mapError { $0 as? AuthDomainError ?? .unknown }
            .eraseToAnyPublisher()
    }
}
