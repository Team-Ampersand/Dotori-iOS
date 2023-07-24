public protocol RemoteNoticeDataSource {
    func fetchNoticeList() async throws -> [NoticeEntity]
}
