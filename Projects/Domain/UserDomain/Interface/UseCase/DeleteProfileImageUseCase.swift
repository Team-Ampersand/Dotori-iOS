import Foundation

public protocol DeleteProfileImageUseCase {
    func callAsFunction(profileImage: Data) async throws
}
