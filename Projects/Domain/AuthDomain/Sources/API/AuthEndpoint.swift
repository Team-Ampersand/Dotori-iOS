import BaseDomain
import Emdpoint

enum AuthEndpoint {
    case signin
}

extension AuthEndpoint: DotoriEndpoint {
    typealias ErrorType = Error

    var route: Route {
        .post("/auth")
    }

    var task: HTTPTask {
        .requestPlain
    }

    var jwtTokenType: JwtTokenType {
        .none
    }

    var errorMapper: [Int : ErrorType]? {
        [:]
    }
}
