import Foundation
import UserDomainInterface

final class RemoteUserDataSourceSpy: RemoteUserDataSource {
    var withdrawalCallCount = 0
    func withdrawal() async throws {
        withdrawalCallCount += 1
    }

    func addProfileImage() async throws {}

    func editProfileImage() async throws {}

    func deleteProfileImage() async throws {}
}
