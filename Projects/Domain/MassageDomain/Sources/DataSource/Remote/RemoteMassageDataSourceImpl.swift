import NetworkingInterface
import MassageDomainInterface

final class RemoteMassageDataSourceImpl: RemoteMassageDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchMassageInfo() async throws -> MassageInfoEntity {
        try await networking.request(
            MassageEndpoint.fetchMassageInfo,
            dto: FetchMassageInfoResponseDTO.self
        )
        .toDomain()
    }

    func applyMassage() async throws {
        try await networking.request(MassageEndpoint.applyMassage)
    }

    func cancelMassage() async throws {
        try await networking.request(MassageEndpoint.cancelMassage)
    }

    func fetchMassageRankList() async throws -> [MassageRankEntity] {
        try await networking.request(
            MassageEndpoint.fetchMassageRankList,
            dto: FetchMassageRankListResponseDTO.self
        )
        .toDomain()
    }
}
