import BaseDomainInterface
import Foundation
import UserDomainInterface

final class UserRepositoryImpl: UserRepository {
    private let localUserDataSource: any LocalUserDataSource
    private let remoteUserDataSource: any RemoteUserDataSource
    private let remoteHomeDataSource: any RemoteHomeDataSource

    init(
        localUserDataSource: any LocalUserDataSource,
        remoteUserDataSource: any RemoteUserDataSource,
        remoteHomeDataSource: any RemoteHomeDataSource
    ) {
        self.localUserDataSource = localUserDataSource
        self.remoteUserDataSource = remoteUserDataSource
        self.remoteHomeDataSource = remoteHomeDataSource
    }

    func loadCurrentUserRole() throws -> UserRoleType {
        try localUserDataSource.loadCurrentUserRole()
    }

    func logout() {
        localUserDataSource.logout()
    }

    func withdrawal() async throws {
        try await remoteUserDataSource.withdrawal()
    }

    func addProfileImage(profileImage: Data) async throws {
        try await remoteUserDataSource.addProfileImage(profileImage: profileImage)
    }

    func deleteProfileImage() async throws {
        try await remoteUserDataSource.deleteProfileImage()
    }

    func fetchProfileImage() async throws -> String {
        try await remoteHomeDataSource.fetchProfileImage()
    }
}
