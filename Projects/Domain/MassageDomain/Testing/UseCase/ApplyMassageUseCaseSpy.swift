import MassageDomainInterface

final class ApplyMassageUseCaseSpy: ApplyMassageUseCase {
    var applyMassageCallCount = 0
    func callAsFunction() async throws {
        applyMassageCallCount += 1
    }
}
