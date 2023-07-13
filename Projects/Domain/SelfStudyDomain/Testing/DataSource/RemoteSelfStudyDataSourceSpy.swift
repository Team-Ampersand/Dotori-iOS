import SelfStudyDomainInterface

public final class RemoteSelfStudyDataSourceSpy: RemoteSelfStudyDataSource {
    public var fetchSelfStudyInfoCallCount = 0
    public var fetchSelfStudyInfoReturn: SelfStudyInfoEntity = .init(count: 0, limit: 0, selfStudyStatus: .can)
    
    public func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity {
        fetchSelfStudyInfoCallCount += 1
        return fetchSelfStudyInfoReturn
    }
}
