import Foundation

public extension Task where Failure == Error {
    @discardableResult
    static func catching(
        priority: TaskPriority? = nil,
        operation: @Sendable @escaping () async throws -> Success,
        catch: @Sendable @escaping (Error) async throws -> Void = { _ in }
    ) -> Task {
        Task(priority: priority) {
            do {
                return try await operation()
            } catch {
                try await `catch`(error)
                throw error
            }
        }
    }
}
