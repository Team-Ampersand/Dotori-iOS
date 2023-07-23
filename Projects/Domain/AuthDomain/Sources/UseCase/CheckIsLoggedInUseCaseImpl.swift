import AuthDomainInterface

struct CheckIsLoggedInUseCaseImpl: CheckIsLoggedInUseCase {
    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }

    func callAsFunction() async -> IsLoggedIn {
        let isConnected = await authRepository.networkIsConnected()
        let tokenIsExist = authRepository.checkTokenIsExist()

        guard isConnected else {
            return tokenIsExist
        }

        do {
            try await authRepository.tokenRefresh()
            return true
        } catch {
            return false
        }
    }
}
