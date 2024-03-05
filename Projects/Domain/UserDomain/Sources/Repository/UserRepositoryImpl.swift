import BaseDomainInterface
import Foundation
import UserDomainInterface

final class UserRepositoryImpl: UserRepository {
    private let localUserDataSource: any LocalUserDataSource
    private let remoteUserDataSource: any RemoteUserDataSource

    init(
        localUserDataSource: any LocalUserDataSource,
        remoteUserDataSource: any RemoteUserDataSource
    ) {
        self.localUserDataSource = localUserDataSource
        self.remoteUserDataSource = remoteUserDataSource
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

    func addProfileImage(image: Data) async throws {
        try await remoteUserDataSource.addProfileImage()
    }

    func editProfileImage(image: Data) async throws {
        try await remoteUserDataSource.editProfileImage()
    }

    func deleteProfileImage(image: Data) async throws {
        try await remoteUserDataSource.deleteProfileImage()
    }
}
