import NoticeDomainInterface

struct RemoveNoticeUseCaseImpl: RemoveNoticeUseCase {
    private let noticeRepository: any NoticeRepository

    init(noticeRepository: any NoticeRepository) {
        self.noticeRepository = noticeRepository
    }

    func callAsFunction(id: Int) async throws {
        try await noticeRepository.removeNotice(id: id)
    }
}
