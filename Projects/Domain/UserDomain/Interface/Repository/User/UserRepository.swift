import BaseDomainInterface
import Foundation

public protocol UserRepository {
    func loadCurrentUserRole() throws -> UserRoleType
    func logout()
    func withdrawal() async throws
    func addProfileImage(profileImage: Data) async throws
    func deleteProfileImage() async throws
    func fetchProfileImage() async throws -> String
}
