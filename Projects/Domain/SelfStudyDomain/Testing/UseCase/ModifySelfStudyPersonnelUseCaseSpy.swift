import SelfStudyDomainInterface

final class ModifySelfStudyPersonnelUseCaseSpy: ModifySelfStudyPersonnelUseCase {
    var modifySelfStudyPersonnelCallCount = 0
    func callAsFunction(limit: Int) async throws {
        modifySelfStudyPersonnelCallCount += 1
    }
}
