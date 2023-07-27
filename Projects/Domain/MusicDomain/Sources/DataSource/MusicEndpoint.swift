import Emdpoint
import MusicDomainInterface
import NetworkingInterface

enum MusicEndpoint {
    case fetchMusicList(date: String)
    case removeMusic(musicID: Int)
    case proposeMusic(url: String)
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

        case .proposeMusic:
            return .post("")
        }
    }

    var task: HTTPTask {
        switch self {
        case let .fetchMusicList(date):
            return .requestParameters(query: [
                "date": date
            ])

        case let .proposeMusic(url):
            return .requestParameters(body: [
                "url": url
            ])

        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JwtTokenType {
        .accessToken
    }

    var errorMap: [Int: Error] {
        switch self {
        case .proposeMusic:
            return [
                202: MusicDomainError.unavilableDate,
                409: MusicDomainError.musicAlreadyProposed
            ]

        default:
            return [:]
        }
    }
}
