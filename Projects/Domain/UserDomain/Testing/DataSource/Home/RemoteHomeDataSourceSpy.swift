import BaseDomainInterface
import Foundation
import UserDomainInterface

final class RemoteHomeDataSourceSpy: RemoteHomeDataSource {
    var fetchProfileImageCallCount = 0
    var fetchProfileImageHandler: () async throws -> String = {
        fatalError()
    }

    func fetchProfileImage() async throws -> String {
        fetchProfileImageCallCount += 1
        return try await fetchProfileImageHandler()
    }
}
