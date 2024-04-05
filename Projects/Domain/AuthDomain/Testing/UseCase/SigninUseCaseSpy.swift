import AuthDomainInterface

final class SigninUseCaseSpy: SigninUseCase {
    var signinCallCount = 0
    func execute(req: SigninRequestDTO) async throws {
        signinCallCount += 1
    }
}
