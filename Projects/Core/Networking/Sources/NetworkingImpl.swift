import Emdpoint
import Foundation
import NetworkingInterface

public final class NetworkingImpl<Endpoint: DotoriEndpoint>: Networking {
    public typealias Endpoint = Endpoint
    private let client: EmdpointClient<Endpoint>

    public init(client: EmdpointClient<Endpoint>) {
        self.client = client
    }

    public func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T {
        let response = try await performRequest(endpoint)
        return try JSONDecoder().decode(dto, from: response.data)
    }

    public func request(_ endpoint: Endpoint) async throws {
        try await performRequest(endpoint)
    }
}

private extension NetworkingImpl {
    @discardableResult
    func performRequest(_ endpoint: Endpoint) async throws -> DataResponse {
        do {
            return try await client.request(endpoint)
        } catch {
            guard
                case let EmdpointError.statusCode(response) = error,
                let httpResponse = response.response as? HTTPURLResponse
            else {
                throw error
            }
            throw endpoint.errorMapper?[httpResponse.statusCode] ?? error
        }
    }
}
