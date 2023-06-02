import Combine
import DateUtility
import Emdpoint
import Foundation
import JwtStoreInterface

open class BaseRemoteDataSource<Endpoint: DotoriEndpoint>:
    HasJwtStore,
    HasEmdpointClient,
    HasJSONDecoder,
    RemoteRequestable {
    public let jwtStore: any JwtStore
    public let client: EmdpointClient<Endpoint>
    public let decoder: JSONDecoder
    public let maxRetryCount = 2

    public init(
        jwtStore: any JwtStore,
        client: EmdpointClient<Endpoint>? = nil,
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
