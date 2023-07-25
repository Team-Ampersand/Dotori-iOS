public protocol CheckSelfStudyMemberUseCase {
    func callAsFunction(memberID: Int, isChecked: Bool) async throws
}
