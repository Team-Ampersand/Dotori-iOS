import MassageDomainInterface

final class MassageRepositoryImpl: MassageRepository {
    private let remoteMassageDataSource: any RemoteMassageDataSource

    init(remoteMassageDataSource: any RemoteMassageDataSource) {
        self.remoteMassageDataSource = remoteMassageDataSource
    }

    func fetchMassageInfo() async throws -> MassageInfoEntity {
        try await remoteMassageDataSource.fetchMassageInfo()
    }

    func applyMassage() async throws {
        try await remoteMassageDataSource.applyMassage()
    }

    func cancelMassage() async throws {
        try await remoteMassageDataSource.cancelMassage()
    }

    func fetchMassageRankList() async throws -> [MassageRankEntity] {
        try await remoteMassageDataSource.fetchMassageRankList()
    }

    func modifyMassagePersonnel(limit: Int) async throws {
        try await remoteMassageDataSource.modifyMassagePersonnel(limit: limit)
    }
}
