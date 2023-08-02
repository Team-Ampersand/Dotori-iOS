import Combine
import Foundation

public protocol RemoteAuthDataSource {
    func signin(req: SigninRequestDTO) async throws
    func tokenRefresh() async throws
    func networkIsConnected() async -> Bool
    func withdrawal() async throws
}
