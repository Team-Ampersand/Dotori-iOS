import Foundation

struct JwtTokenDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
}
