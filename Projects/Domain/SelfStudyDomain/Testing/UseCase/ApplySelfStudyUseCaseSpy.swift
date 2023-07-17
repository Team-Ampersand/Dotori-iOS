import SelfStudyDomainInterface

final class ApplySelfStudyUseCaseSpy: ApplySelfStudyUseCase {
    var applySelfStudyCallCount = 0
    func callAsFunction() async throws {
        applySelfStudyCallCount += 1
    }
}
