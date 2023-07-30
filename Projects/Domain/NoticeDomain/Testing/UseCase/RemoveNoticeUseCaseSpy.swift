import NoticeDomainInterface

final class RemoveNoticeUseCaseSpy: RemoveNoticeUseCase {
    var removeNoticeCallCount = 0
    var removeNoticeHandler: (Int) async throws -> Void = { _ in }
    func callAsFunction(id: Int) async throws {
        removeNoticeCallCount += 1
        try await removeNoticeHandler(id)
    }
}
