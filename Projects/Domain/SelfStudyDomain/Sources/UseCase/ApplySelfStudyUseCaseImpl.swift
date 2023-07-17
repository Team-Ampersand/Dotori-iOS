import SelfStudyDomainInterface

struct ApplySelfStudyUseCaseImpl: ApplySelfStudyUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction() async throws {
        try await selfStudyRepository.applySelfStudy()
    }
}
