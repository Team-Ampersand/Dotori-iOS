import AuthDomainInterface

final class AuthRepositorySpy: AuthRepository {
    var signinCallCount = 0
    var signinThrowingError: Error?
    func signin(req: SigninRequestDTO) async throws {
        signinCallCount += 1
        if let error = signinThrowingError {
            throw error
        }
    }

    var loadJwtTokenCallCount = 0
    var loadJwtTokenReturn: JwtTokenEntity = .init(
        accessToken: "access",
        refreshToken: "refresh",
        expiresAt: "expires"
    )
    func loadJwtToken() -> JwtTokenEntity {
        loadJwtTokenCallCount += 1
        return loadJwtTokenReturn
    }

    var tokenRefreshCallCount = 0
    var tokenRefreshThrowingError: Error?
    func tokenRefresh() async throws {
        tokenRefreshCallCount += 1
        if let error = tokenRefreshThrowingError {
            throw error
        }
    }

    var networkIsConnectedCallCount = 0
    var networkIsConnectedReturn = true
    func networkIsConnected() async -> Bool {
        networkIsConnectedCallCount += 1
        return networkIsConnectedReturn
    }

    var checkTokenIsExistCallCount = 0
    var checkTokenIsExistReturn = true
    func checkTokenIsExist() -> Bool {
        checkTokenIsExistCallCount += 1
        return checkTokenIsExistReturn
    }

    var withdrawalCallCount = 0
    func withdrawal() async throws {
        withdrawalCallCount += 1
    }
}
