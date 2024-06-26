import NetworkingInterface
import SelfStudyDomainInterface

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
        .toDomain()
    }

    func applySelfStudy() async throws {
        try await networking.request(SelfStudyEndpoint.applySelfStudy)
    }

    func cancelSelfStudy() async throws {
        try await networking.request(SelfStudyEndpoint.cancelSelfStudy)
    }

    func fetchSelfStudyRankList() async throws -> [SelfStudyRankEntity] {
        try await networking.request(
            SelfStudyEndpoint.fetchSelfStudyRank,
            dto: FetchSelfStudyRankListResponseDTO.self
        )
        .toDomain()
    }

    func fetchSelfStudyRankSearch(
        req: FetchSelfStudyRankSearchRequestDTO
    ) async throws -> [SelfStudyRankEntity] {
        try await networking.request(
            SelfStudyEndpoint.fetchSelfStudySearch(req),
            dto: FetchSelfStudyRankListResponseDTO.self
        )
        .toDomain()
    }

    func checkSelfStudyMember(memberID: Int, isChecked: Bool) async throws {
        try await networking.request(
            SelfStudyEndpoint.checkSelfStudyMember(memberID: memberID, isChecked: isChecked)
        )
    }

    func modifySelfStudyPersonnel(limit: Int) async throws {
        try await networking.request(SelfStudyEndpoint.modifySelfStudyPersonnel(limit: limit))
    }
}
