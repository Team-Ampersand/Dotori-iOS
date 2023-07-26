import MassageDomainInterface

struct FetchMassageRankListUseCaseImpl: FetchMassageRankListUseCase {
    private let massageRepository: any MassageRepository

    init(massageRepository: any MassageRepository) {
        self.massageRepository = massageRepository
    }

    func callAsFunction() async throws -> [MassageRankModel] {
        try await massageRepository.fetchMassageRankList()
    }
}
