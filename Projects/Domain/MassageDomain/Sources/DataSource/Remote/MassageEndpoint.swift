import Emdpoint
import NetworkingInterface

public enum MassageEndpoint {
    case fetchMassageInfo
}

extension MassageEndpoint: DotoriEndpoint {
    public var domain: DotoriRestAPIDomain {
        .massage
    }

    public var route: Route {
        switch self {
        case .fetchMassageInfo:
            return .get("")
        }
    }

    public var task: HTTPTask {
        switch self {
        case .fetchMassageInfo:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        switch self {
        case .fetchMassageInfo:
            return .accessToken
        }
    }
}
