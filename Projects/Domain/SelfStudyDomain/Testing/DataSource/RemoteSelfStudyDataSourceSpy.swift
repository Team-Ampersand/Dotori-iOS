import SelfStudyDomainInterface

final class RemoteSelfStudyDataSourceSpy: RemoteSelfStudyDataSource {
    var fetchSelfStudyInfoCallCount = 0
    var fetchSelfStudyInfoReturn: SelfStudyInfoEntity = .init(count: 0, limit: 0, selfStudyStatus: .can)

    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity {
        fetchSelfStudyInfoCallCount += 1
        return fetchSelfStudyInfoReturn
    }

    var applySelfStudyCallCount = 0
    func applySelfStudy() async throws {
        applySelfStudyCallCount += 1
    }

    var cancelSelfStudyCallCount = 0
    func cancelSelfStudy() async throws {
        cancelSelfStudyCallCount += 1
    }

    var fetchSelfStudyRankListCallCount = 0
    var fetchSelfStudyRankListReturn: [SelfStudyRankEntity] = []
    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity] {
        fetchSelfStudyRankListCallCount += 1
        return fetchSelfStudyRankListReturn
    }

    var fetchSelfStudyRankSearchCallCount = 0
    var fetchSelfStudyRankSearchReturn: [SelfStudyRankEntity] = []
    func fetchSelfStudyRankSearch(req: FetchSelfStudyRankSearchRequestDTO) async throws -> [SelfStudyRankEntity] {
        fetchSelfStudyRankSearchCallCount += 1
        return fetchSelfStudyRankSearchReturn
    }

    var checkSelfStudyMemberCallCount = 0
    func checkSelfStudyMember(memberID: Int, isChecked: Bool) async throws {
        checkSelfStudyMemberCallCount += 1
    }
}
