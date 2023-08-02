import UserDomainInterface
import NetworkingInterface

final class RemoteUserDataSourceImpl: RemoteUserDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func withdrawal() async throws {
        try await networking.request(UserEndpoint.withdrawal)
    }
}
