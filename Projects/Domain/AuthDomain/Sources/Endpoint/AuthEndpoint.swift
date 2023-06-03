import AuthDomainInterface
import BaseDomain
import Emdpoint

enum AuthEndpoint {
    case signin(SigninRequestDTO)
    case refresh
}

extension AuthEndpoint: DotoriEndpoint {
    typealias ErrorType = AuthDomainError

    var domain: DotoriRestAPIDomain {
        .auth
    }

    var route: Route {
        switch self {
        case .signin:
            return .post("")

        case .refresh:
            return .patch("")
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

    var errorMapper: [Int: ErrorType]? {
        switch self {
        case .signin:
            return [
                400: .invalidPassword,
                404: .invalidPassword,
                500: .unknown
            ]

        case .refresh:
            return [
                401: .unknown,
                500: .unknown
            ]
        }
    }
}
