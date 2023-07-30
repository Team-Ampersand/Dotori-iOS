import MassageDomainInterface

struct ModifyMassagePersonnelUseCaseImpl: ModifyMassagePersonnelUseCase {
    private let massageRepository: any MassageRepository

    init(massageRepository: any MassageRepository) {
        self.massageRepository = massageRepository
    }

    func callAsFunction(limit: Int) async throws {
        try await massageRepository.modifyMassagePersonnel(limit: limit)
    }
}
