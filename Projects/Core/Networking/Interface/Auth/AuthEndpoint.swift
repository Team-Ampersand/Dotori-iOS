import Emdpoint

public enum AuthEndpoint {
    case signin(email: String, password: String)
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
        case let .signin(email, password):
            return .requestParameters(body: [
                "email": email,
                "password": password
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

    public var errorMapper: [Int: ErrorType]? {
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
