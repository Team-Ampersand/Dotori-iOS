import BaseDomain
import Emdpoint

enum AuthEndpoint {
    case signin
}

extension AuthEndpoint: DotoriEndpoint {
    typealias ErrorType = Error

    var route: Route {
        .post("")
    }

    var task: HTTPTask {
        .requestPlain
    }

    var errorMapper: [Int : ErrorType]? {
        [:]
    }
}
