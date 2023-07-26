import Foundation
import ViolationDomainInterface

final class ViolationRepositoryImpl: ViolationRepository {
    private let remoteViolationDataSource: any RemoteViolationDataSource

    init(remoteViolationDataSource: any RemoteViolationDataSource) {
        self.remoteViolationDataSource = remoteViolationDataSource
    }

    func fetchMyViolationList() async throws -> [ViolationEntity] {
        try await remoteViolationDataSource.fetchMyViolationList()
    }
}
