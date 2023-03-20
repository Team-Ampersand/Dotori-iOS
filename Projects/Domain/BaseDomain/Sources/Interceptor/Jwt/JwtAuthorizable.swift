public enum JwtTokenType: String {
    case accessToken = "Authorization"
    case refreshToken = "refreshToken"
    case none
}

public protocol JwtAuthorizable {
    var jwtTokenType: JwtTokenType { get }
}
