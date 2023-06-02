import Emdpoint
import Foundation
import ConcurrencyUtil

public protocol RemoteRequestable {
    associatedtype Endpoint: DotoriEndpoint

    var maxRetryCount: Int { get }

    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T
    func request(_ endpoint: Endpoint) async throws
}

public extension RemoteRequestable where Self: HasEmdpointClient {
    @discardableResult
    func performRequest(_ endpoint: Endpoint) async throws -> DataResponse {
        try await Task.retrying(priority: Task.currentPriority, maxRetryCount: maxRetryCount) {
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
        .value
    }

    func request(_ endpoint: Endpoint) async throws {
        try await performRequest(endpoint)
    }
}

public extension RemoteRequestable where Self: HasEmdpointClient, Self: HasJSONDecoder {
    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T {
        let response = try await performRequest(endpoint)
        return try decoder.decode(dto, from: response.data)
    }
}
