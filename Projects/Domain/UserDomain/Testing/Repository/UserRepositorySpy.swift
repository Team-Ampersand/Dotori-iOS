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
}
