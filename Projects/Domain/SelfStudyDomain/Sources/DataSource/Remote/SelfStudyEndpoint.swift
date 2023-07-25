import Emdpoint
import NetworkingInterface
import SelfStudyDomainInterface

public enum SelfStudyEndpoint {
    case fetchSelfStudyInfo
    case applySelfStudy
    case cancelSelfStudy
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

        case .cancelSelfStudy:
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
        case .applySelfStudy:
            return [
                409: SelfStudyDomainError.selfStudyLimitExceeded
            ]

        default:
            return [:]
        }
    }
}
