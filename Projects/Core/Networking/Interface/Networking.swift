import Emdpoint
import Foundation

public protocol Networking<Endpoint> where Endpoint: DotoriEndpoint {
    associatedtype Endpoint: DotoriEndpoint

    func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) async throws -> T
    func request(_ endpoint: Endpoint) async throws
}
