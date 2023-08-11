import AuthDomainInterface
import BaseDomain
import Combine
import Foundation
import Network
import NetworkingInterface

final class RemoteAuthDataSourceImpl: RemoteAuthDataSource {
    private let networking: any Networking

    init(networking: any Networking) {
        self.networking = networking
    }

    func signin(req: SigninRequestDTO) async throws {
        try await networking.request(AuthEndpoint.signin(email: req.email, password: req.password))
    }

    func tokenRefresh() async throws {
        try await networking.request(AuthEndpoint.refresh)
    }

    func networkIsConnected() async -> Bool {
        return await withCheckedContinuation { continuation in
            let monitor = NWPathMonitor()

            monitor.pathUpdateHandler = { path in
                monitor.cancel()
                switch path.status {
                case .satisfied:
                    continuation.resume(returning: true)
                case .unsatisfied, .requiresConnection:
                    continuation.resume(returning: false)
                @unknown default:
                    continuation.resume(returning: false)
                }
            }
            monitor.start(queue: DispatchQueue(label: "InternetConnectionMonitor"))
        }
    }
}
