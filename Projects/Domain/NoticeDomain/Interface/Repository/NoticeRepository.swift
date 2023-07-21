public protocol NoticeRepository {
    func fetchNoticeList() async throws -> [NoticeEntity]
}
