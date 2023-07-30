import Emdpoint
import NetworkingInterface
import SelfStudyDomainInterface

public enum SelfStudyEndpoint {
    case fetchSelfStudyInfo
    case applySelfStudy
    case cancelSelfStudy
    case fetchSelfStudyRank
    case fetchSelfStudySearch(FetchSelfStudyRankSearchRequestDTO)
    case checkSelfStudyMember(memberID: Int, isChecked: Bool)
    case modifySelfStudyPersonnel(limit: Int)
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

        case .fetchSelfStudyRank:
            return .get("/rank")

        case .fetchSelfStudySearch:
            return .get("/search")

        case let .checkSelfStudyMember(memberID, _):
            return .patch("/check/\(memberID)")

        case .modifySelfStudyPersonnel:
            return .patch("/limit")
        }
    }

    public var task: HTTPTask {
        switch self {
        case let .fetchSelfStudySearch(req):
            return .requestParameters(query: req.toDictionary())

        case let .checkSelfStudyMember(_, isChecked):
            return .requestParameters(body: [
                "selfStudyCheck": isChecked
            ])

        case let .modifySelfStudyPersonnel(limit):
            return .requestParameters(body: [
                "limit": limit
            ])

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
