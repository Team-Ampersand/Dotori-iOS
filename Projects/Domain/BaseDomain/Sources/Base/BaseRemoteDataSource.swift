import Combine
import Emdpoint
import Foundation
import JwtStoreInterface

open class BaseRemoteDataSource<Endpoint: DotoriEndpoint> {
    private let jwtStore: any JwtStore
    private let client: EmdpointClient<Endpoint>
    private let decoder: JSONDecoder
    private let maxRetryCount = 2

    public init(
        jwtStore: any JwtStore,
        client: EmdpointClient<Endpoint>?,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.jwtStore = jwtStore
        #if DEV || STAGE
        self.client = EmdpointClient(
            interceptors: [JwtInterceptor(jwtStore: jwtStore), DotoriLoggingInterceptor()]
        )
        #else
        self.client = EmdpointClient(
            interceptors: [JwtInterceptor(jwtStore: jwtStore)]
        )
        #endif
        self.decoder = decoder
    }

    
}

private extension BaseRemoteDataSource {
    
    func checkIsEndpointNeedsAuthorization(_ endpoint: Endpoint) -> Bool {
        endpoint.jwtTokenType == .accessToken
    }
}
