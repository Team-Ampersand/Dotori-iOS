import BaseDomainInterface
import Foundation
import UserDomainInterface

final class LocalUserDataSourceSpy: LocalUserDataSource {
    var loadCurrentUserRoleCallCount = 0
    var loadCurrentUserRoleReturn: UserRoleType = .member
    func loadCurrentUserRole() throws -> UserRoleType {
        loadCurrentUserRoleCallCount += 1
        return loadCurrentUserRoleReturn
    }
}
