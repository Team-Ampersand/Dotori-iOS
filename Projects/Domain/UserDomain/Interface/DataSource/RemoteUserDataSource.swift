public protocol RemoteUserDataSource {
    func withdrawal() async throws
    func addProfileImage() async throws
    func editProfileImage() async throws
    func deleteProfileImage() async throws
}
