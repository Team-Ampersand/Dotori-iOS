import SelfStudyDomainInterface

final class CheckSelfStudyMemberUseCaseSpy: CheckSelfStudyMemberUseCase {
    var checkSelfStudyMemberCallCount = 0
    func callAsFunction(memberID: Int, isChecked: Bool) async throws {
        checkSelfStudyMemberCallCount += 1
    }
}
