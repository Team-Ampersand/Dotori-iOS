import MassageDomainInterface

final class RemoteMassageDataSourceSpy: RemoteMassageDataSource {
    var fetchMassageInfoCallCount = 0
    var fetchMassageInfoReturn: MassageInfoEntity = .init(count: 0, limit: 0, massageStatus: .can)
    func fetchMassageInfo() async throws -> MassageInfoEntity {
        fetchMassageInfoCallCount += 1
        return fetchMassageInfoReturn
    }

    var applyMassageCallCount = 0
    func applyMassage() async throws {
        applyMassageCallCount += 1
    }

    var cancelMassageCallCount = 0
    func cancelMassage() async throws {
        cancelMassageCallCount += 1
    }
}
