import Emdpoint

enum RefreshEndpoint {
    case refresh
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

    var errorMapper: [Int: ErrorType]? {
        [
            400: .invalidToken,
            401: .expiredToken,
            500: .unknown
        ]
    }
}
