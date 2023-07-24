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
}
