import Emdpoint
import Foundation

public protocol RemoteRequestable {
    associatedtype Endpoint: DotoriEndpoint

    var maxRetryCount: Int { get }

    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T
    func request(_ endpoint: Endpoint) async throws
}
