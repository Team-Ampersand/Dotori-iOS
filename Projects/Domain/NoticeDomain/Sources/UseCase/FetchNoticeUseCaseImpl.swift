import NoticeDomainInterface

struct FetchNoticeUseCaseImpl: FetchNoticeUseCase {
    private let noticeRepository: any NoticeRepository

    init(noticeRepository: any NoticeRepository) {
        self.noticeRepository = noticeRepository
    }

    func callAsFunction(id: Int) async throws -> DetailNoticeModel {
        try await noticeRepository.fetchNotice(id: id)
    }
}
