public protocol RemoveNoticeUseCase {
    func callAsFunction(id: Int) async throws
}
