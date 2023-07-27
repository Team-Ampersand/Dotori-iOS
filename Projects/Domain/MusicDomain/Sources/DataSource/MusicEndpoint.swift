import Emdpoint
import NetworkingInterface

enum MusicEndpoint {
    case fetchMusicList(date: String)
    case removeMusic(musicID: Int)
}

extension MusicEndpoint: DotoriEndpoint {
    var domain: DotoriRestAPIDomain {
        .music
    }

    var route: Route {
        switch self {
        case .fetchMusicList:
            return .get("")

        case let .removeMusic(musicID):
            return .delete("/\(musicID)")
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
