import AuthDomainInterface
import Combine
import JwtStoreInterface

struct LocalAuthDataSourceImpl: LocalAuthDataSource {
    private let jwtStore: any JwtStore

    func loadJwtToken() -> AnyPublisher<JwtTokenEntity, Never> {
        let tokenEntity = JwtTokenEntity(
            accessToken: jwtStore.load(property: .accessToken),
            refreshToken: jwtStore.load(property: .refreshToken)
        )
        return Just(tokenEntity)
            .eraseToAnyPublisher()
    }
}
