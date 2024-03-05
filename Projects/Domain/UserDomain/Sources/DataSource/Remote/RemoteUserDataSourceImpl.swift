import NetworkingInterface
import UserDomainInterface

final class RemoteUserDataSourceImpl: RemoteUserDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func withdrawal() async throws {
        try await networking.request(UserEndpoint.withdrawal)
    }

    func addProfileImage() async throws {
        try await networking.request(UserEndpoint.addProfileImage)
    }

    func editProfileImage() async throws {
        try await networking.request(UserEndpoint.editProfileImage)
    }

    func deleteProfileImage() async throws {
        try await networking.request(UserEndpoint.deleteProfileImage)
    }
}
