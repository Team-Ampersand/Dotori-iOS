import MassageDomainInterface

struct ApplyMassageUseCaseImpl: ApplyMassageUseCase {
    private let massageRepository: any MassageRepository

    init(massageRepository: any MassageRepository) {
        self.massageRepository = massageRepository
    }

    func callAsFunction() async throws {
        try await massageRepository.applyMassage()
    }
}
