import Combine

public protocol SigninUseCase {
    func execute(req: SigninRequestDTO) async throws
}
