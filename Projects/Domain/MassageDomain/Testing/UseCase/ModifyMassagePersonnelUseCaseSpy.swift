import MassageDomainInterface

final class ModifyMassagePersonnelUseCaseSpy: ModifyMassagePersonnelUseCase {
    var modifyMassagePersonnelCallCount = 0
    func callAsFunction(limit: Int) async throws {
        modifyMassagePersonnelCallCount += 1
    }
}
