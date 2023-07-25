import MassageDomainInterface

final class CancelMassageUseCaseSpy: CancelMassageUseCase {
    var cancelMassageCallCount = 0
    func callAsFunction() async throws {
        cancelMassageCallCount += 1
    }
}
