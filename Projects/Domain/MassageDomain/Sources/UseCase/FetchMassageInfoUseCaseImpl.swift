import MassageDomainInterface

struct FetchMassageInfoUseCaseImpl: FetchMassageInfoUseCase {
    private let massageRepository: any MassageRepository

    init(massageRepository: any MassageRepository) {
        self.massageRepository = massageRepository
    }

    func callAsFunction() async throws -> MassageInfoModel {
        try await massageRepository.fetchMassageInfo()
    }
}
