import SelfStudyDomainInterface

struct FetchSelfStudyRankListUseCaseImpl: FetchSelfStudyRankListUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction() async throws -> [SelfStudyRankModel] {
        try await selfStudyRepository.fetchSelfStudyRankList()
    }
}
