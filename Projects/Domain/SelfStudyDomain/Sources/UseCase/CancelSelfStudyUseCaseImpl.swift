import SelfStudyDomainInterface

struct CancelSelfStudyUseCaseImpl: CancelSelfStudyUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction() async throws {
        try await selfStudyRepository.cancelSelfStudy()
    }
}
