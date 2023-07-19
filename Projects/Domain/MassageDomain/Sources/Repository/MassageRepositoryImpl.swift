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
}
