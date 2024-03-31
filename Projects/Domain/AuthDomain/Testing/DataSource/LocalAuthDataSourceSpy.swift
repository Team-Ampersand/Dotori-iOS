import AuthDomainInterface

final class LocalAuthDataSourceSpy: LocalAuthDataSource {
    var loadJwtTokenCallCount = 0
    var loadJwtTokenReturn: JwtTokenEntity = .init(
        accessToken: "access",
        refreshToken: "refresh",
        expiresAt: "expires"
    )
    func loadJwtToken() -> AuthDomainInterface.JwtTokenEntity {
        loadJwtTokenCallCount += 1
        return loadJwtTokenReturn
    }

    var checkTokenIsExistCallCount = 0
    var checkTokenIsExistReturn: Bool = false
    func checkTokenIsExist() -> Bool {
        checkTokenIsExistCallCount += 1
        return checkTokenIsExistReturn
    }
}
