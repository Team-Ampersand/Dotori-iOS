import NoticeDomainInterface

final class FetchNoticeUseCaseSpy: FetchNoticeUseCase {
    var fetchNoticeCallCount = 0
    var fetchNoticeHandler: (Int) async throws -> DetailNoticeModel = { _ in
        .init(
            id: 1,
            title: "",
            content: "",
            role: .member,
            images: [],
            createdDate: .init()
        )
    }

    func callAsFunction(id: Int) async throws -> DetailNoticeModel {
        fetchNoticeCallCount += 1
        return try await fetchNoticeHandler(id)
    }
}
