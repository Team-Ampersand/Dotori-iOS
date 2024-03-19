import Foundation
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

    func addProfileImage(profileImage: Data) async throws {
        try await networking.request(UserEndpoint.addProfileImage(profileImage: profileImage))
    }

    func deleteProfileImage() async throws {
        try await networking.request(UserEndpoint.deleteProfileImage)
    }
}
