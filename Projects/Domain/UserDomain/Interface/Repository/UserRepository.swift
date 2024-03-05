import BaseDomainInterface
import Foundation

public protocol UserRepository {
    func loadCurrentUserRole() throws -> UserRoleType
    func logout()
    func withdrawal() async throws
    func addProfileImage(image: Data) async throws
    func editProfileImage(image: Data) async throws
    func deleteProfileImage(image: Data) async throws
}
