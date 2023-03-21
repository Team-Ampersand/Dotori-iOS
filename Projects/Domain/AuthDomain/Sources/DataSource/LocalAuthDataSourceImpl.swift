import AuthDomainInterface
import Combine
import JwtStoreInterface

struct LocalAuthDataSourceImpl: LocalAuthDataSource {
    private let jwtStore: any JwtStore

    init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    func loadJwtToken() -> JwtTokenEntity {
        JwtTokenEntity(
            accessToken: jwtStore.load(property: .accessToken),
            refreshToken: jwtStore.load(property: .refreshToken),
            expiresAt: jwtStore.load(property: .accessExpiresAt)
        )
    }
}
