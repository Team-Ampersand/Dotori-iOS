import Emdpoint
import NetworkingInterface

public enum UserEndpoint {
    case withdrawal
    case addProfileImage
    case editProfileImage
    case deleteProfileImage
}

extension UserEndpoint: DotoriEndpoint {
    public var domain: DotoriRestAPIDomain {
        .user
    }

    public var route: Route {
        switch self {
        case .withdrawal:
            return .delete("/withdrawal")
        case .addProfileImage:
            return .post("/profileImage")
        case .editProfileImage:
            return .patch("/profileImage")
        case .deleteProfileImage:
            return .delete("/profileImage")
        }
    }

    public var task: HTTPTask {
        switch self {
        default:
            return .requestPlain
        }
    }

    public var jwtTokenType: JwtTokenType {
        switch self {
        default:
            return .accessToken
        }
    }

    public var errorMap: [Int: Error] {
        switch self {
        default:
            return [:]
        }
    }
}
