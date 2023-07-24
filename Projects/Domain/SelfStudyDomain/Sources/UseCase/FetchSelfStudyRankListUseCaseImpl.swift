import SelfStudyDomainInterface

struct FetchSelfStudyRankListUseCaseImpl: FetchSelfStudyRankListUseCase {
    private let selfStudyRepository: any SelfStudyRepository

    init(selfStudyRepository: any SelfStudyRepository) {
        self.selfStudyRepository = selfStudyRepository
    }

    func callAsFunction(req: FetchSelfStudyRankSearchRequestDTO?) async throws -> [SelfStudyRankModel] {
        if let req {
            return try await selfStudyRepository.fetchSelfStudyRankSearch(req: req)
        } else {
            return try await selfStudyRepository.fetchSelfStudyRankList()
        }
    }
}
