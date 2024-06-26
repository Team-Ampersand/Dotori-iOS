import MassageDomainInterface

final class MassageRepositorySpy: MassageRepository {
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

    var fetchMassageRankListCallCount = 0
    var fetchMassageRankListHandler: () async throws -> [MassageRankEntity] = { [] }
    func fetchMassageRankList() async throws -> [MassageRankEntity] {
        fetchMassageRankListCallCount += 1
        return try await fetchMassageRankListHandler()
    }

    var modifyMassagePersonnelCallCount = 0
    func modifyMassagePersonnel(limit: Int) async throws {
        modifyMassagePersonnelCallCount += 1
    }
}
