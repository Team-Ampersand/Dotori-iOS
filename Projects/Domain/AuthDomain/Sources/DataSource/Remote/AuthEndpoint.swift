import AuthDomainInterface
import Emdpoint
import NetworkingInterface

public enum AuthEndpoint {
    case signin(code: String)
    case refresh
}

extension AuthEndpoint: DotoriEndpoint {
    public var domain: DotoriRestAPIDomain {
        .auth
    }

    public var route: Route {
        switch self {
        case .signin:
            return .post("")

        case .refresh:
            return .patch("")
        }
    }

    public var task: HTTPTask {
        switch self {
        case let .signin(code):
            return .requestParameters(body: [
                "code": code
            ])

        default:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        switch self {
        case .refresh:
            return .refreshToken

        default:
            return .none
        }
    }

    public var errorMap: [Int: Error] {
        switch self {
        case .signin:
            return [
                401: AuthDomainError.codeExpired,
                404: AuthDomainError.codeExpired,
                500: AuthDomainError.unknown
            ]

        default:
            return [:]
        }
    }
}
