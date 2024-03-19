import Foundation

public protocol FetchProfileImageUseCase {
    func callAsFunction() async throws -> String
}
