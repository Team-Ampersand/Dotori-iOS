import AuthDomainInterface
import Combine

struct SigninUseCaseImpl: SigninUseCase {
    private let authRepository: any AuthRepository

    init(authRepository: any AuthRepository) {
        self.authRepository = authRepository
    }

    func execute(req: SigninRequestDTO) async throws {
        try await authRepository.signin(req: req)
    }
}
