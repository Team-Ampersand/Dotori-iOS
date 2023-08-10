import Emdpoint
import NetworkingInterface

enum RefreshEndpoint {
    case refresh(refreshToken: String)
}

extension RefreshEndpoint: DotoriEndpoint {
    typealias ErrorType = RefreshError

    var domain: DotoriRestAPIDomain {
        .auth
    }

    var route: Route {
        .patch("")
    }

    var task: HTTPTask {
        .requestPlain
    }

    var jwtTokenType: JwtTokenType {
        .refreshToken
    }

    var headers: [String: String]? {
        switch self {
        case let .refresh(refreshToken):
            return ["refreshToken": refreshToken]
        }
    }

    var errorMapper: [Int: ErrorType]? {
        [
            400: .invalidToken,
            401: .expiredToken,
            500: .unknown
        ]
    }
}
