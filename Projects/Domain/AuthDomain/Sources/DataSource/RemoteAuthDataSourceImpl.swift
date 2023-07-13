import AuthDomainInterface
import BaseDomain
import Combine
import NetworkingInterface

final class RemoteAuthDataSourceImpl: RemoteAuthDataSource {
    private let authNetworking: any Networking

    init(authNetworking: any Networking) {
        self.authNetworking = authNetworking
    }

    func signin(req: SigninRequestDTO) async throws {
        try await authNetworking.request(AuthEndpoint.signin(email: req.email, password: req.password))
    }
}
