import Foundation

public protocol AddProfileImageUseCase {
    func callAsFunction(profileImage: Data) async throws
}
