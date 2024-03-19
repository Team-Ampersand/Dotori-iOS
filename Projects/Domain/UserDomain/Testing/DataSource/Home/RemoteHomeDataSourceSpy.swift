import BaseDomainInterface
import Foundation
import UserDomainInterface

final class RemoteHomeDataSourceSpy: RemoteHomeDataSource {
    var fetchUserInfoCallCount = 0
    var fetchUserInfoHandler: () async throws -> String = {
        fatalError()
    }

    func fetchProfileImage() async throws -> String {
        fetchUserInfoCallCount += 1
        return try await fetchUserInfoHandler()
    }
}
