import Emdpoint
import NetworkingInterface
import SelfStudyDomainInterface

public enum SelfStudyEndpoint {
    case fetchSelfStudyInfo
    case applySelfStudy
    case fetchSelfStudyRank
    case fetchSelfStudySearch(FetchSelfStudyRankSearchRequestDTO)
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

        case .fetchSelfStudyRank:
            return .get("/rank")

        case .fetchSelfStudySearch:
            return .get("/search")
        }
    }

    public var task: HTTPTask {
        switch self {
        case let .fetchSelfStudySearch(req):
            return .requestParameters(query: req.toDictionary())

        default:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        .accessToken
    }

    public var errorMap: [Int: Error] {
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
