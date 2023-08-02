import Foundation
import UserDomainInterface

final class RemoteUserDataSourceSpy: RemoteUserDataSource {
    var withdrawalCallCount = 0
    func withdrawal() async throws {
        withdrawalCallCount += 1
    }
}
