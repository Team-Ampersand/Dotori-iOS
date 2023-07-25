import Emdpoint
import Foundation
import MassageDomainInterface
import NetworkingInterface

public enum MassageEndpoint {
    case fetchMassageInfo
    case applyMassage
    case cancelMassage
}

extension MassageEndpoint: DotoriEndpoint {
    public var domain: DotoriRestAPIDomain {
        .massage
    }

    public var route: Route {
        switch self {
        case .fetchMassageInfo:
            return .get("")

        case .applyMassage:
            return .post("")

        case .cancelMassage:
            return .delete("")
        }
    }

    public var task: HTTPTask {
        switch self {
        default:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int : Error] {
        switch self {
        case .applyMassage:
            return [
                409: MassageDomainError.massageLimitExceeded
            ]

        default:
            return [:]
        }
    }
}
