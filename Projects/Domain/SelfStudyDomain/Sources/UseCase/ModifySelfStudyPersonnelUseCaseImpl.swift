import SelfStudyDomainInterface

struct ModifySelfStudyPersonnelUseCaseImpl: ModifySelfStudyPersonnelUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction(limit: Int) async throws {
        try await selfStudyRepository.modifySelfStudyPersonnel(limit: limit)
    }
}
