import SelfStudyDomainInterface

final class CancelSelfStudyUseCaseSpy: CancelSelfStudyUseCase {
    var cancelSelfStudyCallCount = 0
    func callAsFunction() async throws {
        cancelSelfStudyCallCount += 1
    }
}
