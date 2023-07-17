import Emdpoint
import Foundation
import NetworkingInterface

public enum MassageEndpoint {
    case fetchMassageInfo
    case applyMassage
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
}
