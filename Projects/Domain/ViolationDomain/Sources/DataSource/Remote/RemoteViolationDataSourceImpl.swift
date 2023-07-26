import NetworkingInterface
import ViolationDomainInterface

final class RemoteViolationDataSourceImpl: RemoteViolationDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func fetchMyViolationList() async throws -> [ViolationEntity] {
        try await networking.request(
            ViolationEndpoint.fetchMyViolation,
            dto: FetchMyViolationListResponseDTO.self
        )
        .toDomain()
    }
}
