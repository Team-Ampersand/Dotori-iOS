import Combine
import Foundation

public extension Publisher {
    func tryAsyncMap<T>(
        _ transform: @escaping (Self.Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Self> {
        self.flatMap { value in
            Future { promise in
                Task {
                    do {
                        let result = try await transform(value)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

    func asyncMap<T>(
        _ transform: @escaping (Self.Output) async -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        self.flatMap { value in
            Future { promise in
                Task {
                    let result = await transform(value)
                    promise(.success(result))
                }
            }
        }
    }
}
