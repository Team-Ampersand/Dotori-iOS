import Emdpoint
import NetworkingInterface

enum MusicEndpoint {
    case fetchMusicList(date: String)
}

extension MusicEndpoint: DotoriEndpoint {
    var domain: DotoriRestAPIDomain {
        .music
    }

    var route: Route {
        switch self {
        case .fetchMusicList:
            return .get("")
        }
    }

    var task: HTTPTask {
        switch self {
        case let .fetchMusicList(date):
            return .requestParameters(query: [
                "date": date
            ])
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        .accessToken
    }
}
