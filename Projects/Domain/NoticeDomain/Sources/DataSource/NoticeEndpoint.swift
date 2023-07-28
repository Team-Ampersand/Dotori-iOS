import Emdpoint
import NetworkingInterface

enum NoticeEndpoint {
    case fetchNoticeList
    case fetchNotice(id: Int)
}

extension NoticeEndpoint: DotoriEndpoint {
    var domain: DotoriRestAPIDomain {
        .notice
    }

    var route: Route {
        switch self {
        case .fetchNoticeList:
            return .get("")

        case let .fetchNotice(id):
            return .get("/\(id)")
        }
    }

    var task: HTTPTask {
        switch self {
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        switch self {
        default:
            return .accessToken
        }
    }
}
