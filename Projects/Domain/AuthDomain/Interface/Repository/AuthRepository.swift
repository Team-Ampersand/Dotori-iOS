import Combine
import Foundation
import JwtStoreInterface

public protocol AuthRepository {
    func signin(req: SigninRequestDTO) async throws
    func loadJwtToken() -> JwtTokenEntity
}
