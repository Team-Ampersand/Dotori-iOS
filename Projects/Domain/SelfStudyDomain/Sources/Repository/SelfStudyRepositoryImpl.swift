import SelfStudyDomainInterface

final class SelfStudyRepositoryImpl: SelfStudyRepository {
    private let remoteSelfStudyDataSource: any RemoteSelfStudyDataSource

    init(remoteSelfStudyDataSource: any RemoteSelfStudyDataSource) {
        self.remoteSelfStudyDataSource = remoteSelfStudyDataSource
    }

    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity {
        try await remoteSelfStudyDataSource.fetchSelfStudyInfo()
    }

    func applySelfStudy() async throws {
        try await remoteSelfStudyDataSource.applySelfStudy()
    }

    func cancelSelfStudy() async throws {
        try await remoteSelfStudyDataSource.cancelSelfStudy()
    }
}
