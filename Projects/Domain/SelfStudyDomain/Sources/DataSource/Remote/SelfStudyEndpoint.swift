import Emdpoint
import NetworkingInterface

public enum SelfStudyEndpoint {
    case fetchSelfStudyInfo
    case applySelfStudy
}

extension SelfStudyEndpoint: DotoriEndpoint {
    public var domain: DotoriRestAPIDomain {
        .selfStudy
    }

    public var route: Route {
        switch self {
        case .fetchSelfStudyInfo:
            return .get("/info")

        case .applySelfStudy:
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
