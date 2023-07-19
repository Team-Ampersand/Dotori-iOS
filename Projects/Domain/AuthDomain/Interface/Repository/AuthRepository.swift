import Combine
import Foundation

public protocol AuthRepository {
    func signin(req: SigninRequestDTO) async throws
    func loadJwtToken() -> JwtTokenEntity
}
