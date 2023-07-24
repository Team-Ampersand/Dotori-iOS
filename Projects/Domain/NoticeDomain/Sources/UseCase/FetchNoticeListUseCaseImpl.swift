import NoticeDomainInterface

struct FetchNoticeListUseCaseImpl: FetchNoticeListUseCase {
    private let noticeRepository: any NoticeRepository

    init(noticeRepository: any NoticeRepository) {
        self.noticeRepository = noticeRepository
    }

    func callAsFunction() async throws -> [NoticeModel] {
        try await noticeRepository.fetchNoticeList()
    }
}
