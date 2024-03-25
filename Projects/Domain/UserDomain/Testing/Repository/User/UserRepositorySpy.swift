import BaseDomainInterface
import Foundation
import UserDomainInterface

final class UserRepositorySpy: UserRepository {
    var loadCurrentUserRoleCallCount = 0
    var loadCurrentUserRoleReturn: UserRoleType = .member
    func loadCurrentUserRole() throws -> UserRoleType {
        loadCurrentUserRoleCallCount += 1
        return loadCurrentUserRoleReturn
    }

    var logoutCallCount = 0
    func logout() {
        logoutCallCount += 1
    }

    var withdrawalCallCount = 0
    func withdrawal() async throws {
        withdrawalCallCount += 1
    }

    var addProfileImageCallCount = 0
    func addProfileImage(profileImage: Data) async throws {
        addProfileImageCallCount += 1
    }

    var deleteProfileImageCallCount = 0
    func deleteProfileImage() async throws {
        deleteProfileImageCallCount += 1
    }

    var fetchUserInfoCallCount = 0
    var profileImageReturn: String = ""
    func fetchProfileImage() async throws -> String {
        fetchUserInfoCallCount += 1
        return profileImageReturn
    }
}
