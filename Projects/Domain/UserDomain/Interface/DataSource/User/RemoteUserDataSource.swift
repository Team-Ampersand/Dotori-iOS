import Foundation

public protocol RemoteUserDataSource {
    func withdrawal() async throws
    func addProfileImage(profileImage: Data) async throws
    func deleteProfileImage() async throws
}
