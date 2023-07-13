import AuthDomainInterface
import BaseDomain
import Combine
import NetworkingInterface

final class RemoteAuthDataSourceImpl: RemoteAuthDataSource {
    private let networking: any Networking

    init(authNetworking: any Networking) {
        self.networking = authNetworking
    }

    func signin(req: SigninRequestDTO) async throws {
        try await networking.request(AuthEndpoint.signin(email: req.email, password: req.password))
    }
}
