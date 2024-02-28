import Foundation

public protocol EditProfileImageUseCase {
    func callAsFunction(profileImage: Data) async throws
}
