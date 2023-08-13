import Emdpoint
import Foundation
import NetworkingInterface

final class NetworkingImpl: Networking {
    typealias Endpoint = AnyEndpoint
    private let client: EmdpointClient<Endpoint>

    init(client: EmdpointClient<Endpoint>) {
        self.client = client
    }

    func request<T: Decodable>(_ endpoint: any EndpointType, dto: T.Type) async throws -> T {
        let newEndpoint = AnyEndpoint.endpoint(endpoint)
        let response = try await performRequest(newEndpoint)
        return try JSONDecoder().decode(dto, from: response.data)
    }

    func request(_ endpoint: any EndpointType) async throws {
        let newEndpoint = AnyEndpoint.endpoint(endpoint)
        try await performRequest(newEndpoint)
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
                let httpResponse = response.response as? HTTPURLResponse,
                let dotoriEndpoint = endpoint.endpoint as? DotoriEndpoint
            else {
                throw error
            }
            throw dotoriEndpoint
                .errorMap[httpResponse.statusCode] ?? NetworkingError(statusCode: httpResponse.statusCode)
        }
    }
}
