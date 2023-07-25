import SelfStudyDomainInterface

struct CheckSelfStudyMemberUseCaseImpl: CheckSelfStudyMemberUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction(memberID: Int, isChecked: Bool) async throws {
        try await selfStudyRepository.checkSelfStudyMember(memberID: memberID, isChecked: isChecked)
    }
}
