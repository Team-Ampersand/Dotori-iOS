import Foundation

public struct JwtTokenEntity: Equatable {
    public init(accessToken: String, refreshToken: String, accessExp: String, refreshExp: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.accessExp = accessExp
        self.refreshExp = refreshExp
    }

    public let accessToken: String
    public let refreshToken: String
    public let accessExp: String
    public let refreshExp: String
}
