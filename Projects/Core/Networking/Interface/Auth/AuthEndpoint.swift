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
}
