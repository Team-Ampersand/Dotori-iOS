import Emdpoint
import Foundation

public protocol Networking {

    func request<T: Decodable>(_ endpoint: any EndpointType, dto: T.Type) async throws -> T
    func request(_ endpoint: any EndpointType) async throws
}
