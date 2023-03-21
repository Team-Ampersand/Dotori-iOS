import AuthDomainInterface
import BaseDomain
import Emdpoint

enum AuthEndpoint {
    case signin(SigninRequestDTO)
    case refresh
}

extension AuthEndpoint: DotoriEndpoint {
    typealias ErrorType = Error

    var route: Route {
        switch self {
        case .signin:
            return .post("/auth")

        case .refresh:
            return .patch("/auth")
        }
    }

    var task: HTTPTask {
        switch self {
        case let .signin(req):
            return .requestJSONEncodable(req)

        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        case .refresh:
            return .refreshToken

        default:
            return .none
        }
    }

    var errorMapper: [Int : ErrorType]? {
        [:]
    }
}
