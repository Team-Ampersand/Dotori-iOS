import AuthDomainInterface
import BaseDomain
import Combine

final class RemoteAuthDataSourceImpl: BaseRemoteDataSource<AuthEndpoint>, RemoteAuthDataSource {
    func signin(req: SigninRequestDTO) async throws {
        try await request(.signin(req))
    }
}
