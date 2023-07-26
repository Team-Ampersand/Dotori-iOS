import Emdpoint
import NetworkingInterface

enum MusicEndpoint {
    case fetchMusicList
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
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        .accessToken
    }
}
