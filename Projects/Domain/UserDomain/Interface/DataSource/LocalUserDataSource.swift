import BaseDomainInterface
import Foundation

public protocol LocalUserDataSource {
    func loadCurrentUserRole() throws -> UserRoleType
    func logout()
}
