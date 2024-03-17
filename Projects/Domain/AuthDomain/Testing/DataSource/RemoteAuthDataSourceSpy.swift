import AuthDomainInterface

final class RemoteAuthDataSourceSpy: RemoteAuthDataSource {
    var signinCallCount = 0
    func signin(req: SigninRequestDTO)  async throws {
        signinCallCount += 1
    }

    var tokenRefreshCallCount = 0
    func tokenRefresh() async throws {
        tokenRefreshCallCount += 1
    }
    
    var networkIsConnectedCallCount = 0
    var networkIsConnectedReturn: Bool = .init()
    func networkIsConnected() async -> Bool {
        networkIsConnectedCallCount += 1
        return networkIsConnectedReturn
    }
}
