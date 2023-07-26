import Emdpoint
import NetworkingInterface

enum ViolationEndpoint {
    case fetchMyViolation
}

extension ViolationEndpoint: DotoriEndpoint {
    var domain: DotoriRestAPIDomain {
        .violation
    }

    var route: Route {
        switch self {
        case .fetchMyViolation:
            return .get("")
        }
    }

    var task: HTTPTask {
        switch self {
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        .accessToken
    }
}
