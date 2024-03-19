import Emdpoint
import Foundation
import NetworkingInterface

public enum UserEndpoint {
    case withdrawal
    case addProfileImage(profileImage: Data)
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
        case .deleteProfileImage:
            return .delete("/profileImage")
        }
    }

    public var task: HTTPTask {
        switch self {
        case let .addProfileImage(profileImage):
            return .uploadMultipart([
                MultiPartFormData(
                    field: "image",
                    data: profileImage,
                    fileName: "image.png"
                )
            ])
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

    public var headers: [String: String]? {
        switch self {
        case let .addProfileImage(profileImage):
            return
                [:]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
