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

    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity] {
        try await remoteSelfStudyDataSource.fetchSelfStudyRankList()
    }

    func fetchSelfStudyRankSearch(req: FetchSelfStudyRankSearchRequestDTO) async throws -> [SelfStudyRankEntity] {
        try await remoteSelfStudyDataSource.fetchSelfStudyRankSearch(req: req)
    }

    func checkSelfStudyMember(memberID: Int, isChecked: Bool) async throws {
        try await remoteSelfStudyDataSource.checkSelfStudyMember(memberID: memberID, isChecked: isChecked)
    }
}
