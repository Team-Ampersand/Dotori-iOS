import Emdpoint
import Foundation

public protocol DotoriEndpoint: EndpointType, JwtAuthorizable {
    associatedtype ErrorType: Error
    var domain: DotoriRestAPIDomain { get }
    var errorMapper: [Int: ErrorType]? { get }
}

extension DotoriEndpoint {
    public var baseURL: URL {
        let baseURL = Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        return URL(
            string: "\(baseURL)/\(domain.rawValue)"
        ) ?? URL(string: "https://www.google.com")!
    }

    public var validationCode: ClosedRange<Int> { 200...300 }

    public var headers: [String: String]? {
        switch self {

        default:
            return ["Content-Type": "application/json"]
        }
    }

    public var timeout: TimeInterval { 60 }
}

private class BundleFinder {}

extension Foundation.Bundle {
    static let module = Bundle(for: BundleFinder.self)
}
