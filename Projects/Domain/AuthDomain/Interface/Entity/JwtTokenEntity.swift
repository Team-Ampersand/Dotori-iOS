import Foundation

public struct JwtTokenEntity: Equatable {
    public let accessToken: String
    public let refreshToken: String
}
