import UserDomainInterface

final class WithdrawalUseCaseSpy: WithdrawalUseCase {
    var withdrawalCallCount = 0
    func callAsFunction() async throws {
        withdrawalCallCount += 1
    }
}
