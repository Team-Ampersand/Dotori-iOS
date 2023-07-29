public protocol RemoteNoticeDataSource {
    func fetchNoticeList() async throws -> [NoticeEntity]
    func fetchNotice(id: Int) async throws -> DetailNoticeEntity
    func removeNotice(id: Int) async throws
}
