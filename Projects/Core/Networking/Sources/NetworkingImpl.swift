import Emdpoint
import Foundation
import NetworkingInterface

final class NetworkingImpl<Endpoint: DotoriEndpoint>: Networking {
    private let client: EmdpointClient<Endpoint>

    init(client: EmdpointClient<Endpoint>) {
        self.client = client
    }

    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T {
        let res = try await client.request(endpoint)
        return try JSONDecoder().decode(dto, from: res.data)
    }

    func request(_ endpoint: Endpoint) async throws {
        _ = try await client.request(endpoint)
    }
}
