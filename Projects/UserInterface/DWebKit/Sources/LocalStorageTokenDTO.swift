import Foundation

public struct LocalStorageTokenDTO: Equatable {
    public let accessToken: String
    public let refreshToken: String
    public let expiresAt: String

    public init(accessToken: String, refreshToken: String, expiresAt: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresAt = expiresAt
    }
}
