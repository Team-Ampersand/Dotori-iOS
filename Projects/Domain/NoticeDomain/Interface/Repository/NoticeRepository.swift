public protocol NoticeRepository {
    func fetchNoticeList() async throws -> [NoticeEntity]
    func fetchNotice(id: Int) async throws -> DetailNoticeEntity
}
