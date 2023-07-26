import ViolationDomainInterface

struct FetchMyViolationListUseCaseImpl: FetchMyViolationListUseCase {
    private let violationRepository: any ViolationRepository

    init(violationRepository: any ViolationRepository) {
        self.violationRepository = violationRepository
    }

    func callAsFunction() async throws -> [ViolationModel] {
        try await violationRepository.fetchMyViolationList()
    }
}
