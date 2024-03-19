import Foundation
import UserDomainInterface

final class RemoteUserDataSourceSpy: RemoteUserDataSource {
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
}
