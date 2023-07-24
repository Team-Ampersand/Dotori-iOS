import SelfStudyDomainInterface
import NetworkingInterface

final class RemoteSelfStudyDataSourceImpl: RemoteSelfStudyDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchSelfStudyInfo() async throws -> SelfStudyInfoEntity {
        try await networking.request(
            SelfStudyEndpoint.fetchSelfStudyInfo,
            dto: FetchSelfStudyInfoResponseDTO.self
        )
        .toEntity()
    }

    func applySelfStudy() async throws {
        try await networking.request(SelfStudyEndpoint.applySelfStudy)
    }

    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity] {
        try await networking.request(
            SelfStudyEndpoint.fetchSelfStudyRank,
            dto: FetchSelfStudyRankListResponseDTO.self
        )
        .toDomain()
    }
}
