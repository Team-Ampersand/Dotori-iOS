import Foundation

public protocol FetchProfileImageUseCase {
    func callAsFunction(profileImage: Data) async throws
}
