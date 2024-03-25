import Emdpoint
import NetworkingInterface

enum HomeEndpoint {
    case fetchProfileImage
}

extension HomeEndpoint: DotoriEndpoint {
    var domain: DotoriRestAPIDomain {
        .home
    }

    var route: Route {
        switch self {
        case .fetchProfileImage:
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
        switch self {
        default:
            return .accessToken
        }
    }
}
