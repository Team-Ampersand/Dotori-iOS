public protocol ModifyMassagePersonnelUseCase {
    func callAsFunction(limit: Int) async throws
}
