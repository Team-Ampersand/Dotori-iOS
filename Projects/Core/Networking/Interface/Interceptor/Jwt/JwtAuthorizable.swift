import Foundation

public enum JwtTokenType: String {
    case accessToken = "Authorization"
    case refreshToken = "Refresh-Token"
    case none
}

public protocol JwtAuthorizable {
    var jwtTokenType: JwtTokenType { get }
}
