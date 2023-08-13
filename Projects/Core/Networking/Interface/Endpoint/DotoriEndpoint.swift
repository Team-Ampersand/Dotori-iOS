import Emdpoint
import Foundation

public protocol DotoriEndpoint: EndpointType, JwtAuthorizable {
    var domain: DotoriRestAPIDomain { get }
    var errorMap: [Int: Error] { get }
}

public extension DotoriEndpoint {
    var baseURL: URL {
        let baseURL = Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        return URL(
            string: "\(baseURL)/\(domain.rawValue)"
        ) ?? URL(string: "https://www.google.com")!
    }

    var validationCode: ClosedRange<Int> { 200...300 }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

    var timeout: TimeInterval { 60 }

    var errorMap: [Int: Error] { [:] }
}

private class BundleFinder {}

extension Foundation.Bundle {
    static let module = Bundle(for: BundleFinder.self)
}
