import Foundation

public protocol UserRepository {
    func loadCurrentUserRole() throws -> UserRoleType
}
