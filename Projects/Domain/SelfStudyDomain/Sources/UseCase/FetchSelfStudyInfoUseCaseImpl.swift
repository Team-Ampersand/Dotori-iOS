import SelfStudyDomainInterface

struct FetchSelfStudyInfoUseCaseImpl: FetchSelfStudyInfoUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction() async throws -> SelfStudyInfoModel {
        try await selfStudyRepository.fetchSelfStudyInfo()
    }
}
