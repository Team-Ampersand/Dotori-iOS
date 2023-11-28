import AuthDomainInterface
import Combine
import JwtStoreInterface

final class LocalAuthDataSourceImpl: LocalAuthDataSource {
    private let jwtStore: any JwtStore

    init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    func loadJwtToken() -> JwtTokenEntity {
        JwtTokenEntity(
            accessToken: jwtStore.load(property: .accessToken),
            refreshToken: jwtStore.load(property: .refreshToken),
            accessExp: jwtStore.load(property: .accessExp),
            refreshExp: jwtStore.load(property: .refreshExp)
        )
    }

    func checkTokenIsExist() -> Bool {
        jwtStore.load(property: .accessToken).isEmpty == false
    }
}
