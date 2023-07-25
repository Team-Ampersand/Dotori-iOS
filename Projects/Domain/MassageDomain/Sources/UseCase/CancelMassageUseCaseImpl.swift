import MassageDomainInterface

struct CancelMassageUseCaseImpl: CancelMassageUseCase {
    private let massageRepository: any MassageRepository

    init(massageRepository: any MassageRepository) {
        self.massageRepository = massageRepository
    }

    func callAsFunction() async throws {
        try await massageRepository.cancelMassage()
    }
}
