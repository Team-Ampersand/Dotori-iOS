import Combine
import DateUtility
import Emdpoint
import Foundation
import JwtStoreInterface
import KeyValueStoreInterface

open class BaseRemoteDataSource<Endpoint: DotoriEndpoint>:
    HasJwtStore,
    HasKeyValueStore,
    HasEmdpointClient,
    HasJSONDecoder,
    RemoteRequestable {
    public let jwtStore: any JwtStore
    public let keyValueStore: any KeyValueStore
    public let client: EmdpointClient<Endpoint>
    public let decoder: JSONDecoder
    public let maxRetryCount = 2

    public init(
        jwtStore: any JwtStore,
        keyValueStore: any KeyValueStore,
        client: EmdpointClient<Endpoint>? = nil,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.jwtStore = jwtStore
        self.keyValueStore = keyValueStore
        #if DEV || STAGE
        self.client = EmdpointClient(
            interceptors: [
                JwtInterceptor(jwtStore: jwtStore),
                DotoriLoggingInterceptor(),
                DotoriRoleInterceptor(keyValueStore: keyValueStore)
            ]
        )
        #else
        self.client = EmdpointClient(
            interceptors: [
                JwtInterceptor(jwtStore: jwtStore),
                DotoriRoleInterceptor(keyValueStore: keyValueStore)
            ]
        )
        #endif
        self.decoder = decoder
    }
}
