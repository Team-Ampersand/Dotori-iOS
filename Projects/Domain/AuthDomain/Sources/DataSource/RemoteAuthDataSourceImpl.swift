import AuthDomainInterface
import BaseDomain
import Combine
import NetworkingInterface

final class RemoteAuthDataSourceImpl: RemoteAuthDataSource {
    private let authNetworking: any Networking<AuthEndpoint>

    init(authNetworking: any Networking<AuthEndpoint>) {
        self.authNetworking = authNetworking
    }

    func signin(req: SigninRequestDTO) async throws {
        try await authNetworking.request(.signin(email: req.email, password: req.password))
    }
}
