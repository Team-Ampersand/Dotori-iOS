import Combine
import DateUtility
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

    public func request<T: Decodable>(_ endpoint: Endpoint, dto: T.Type) -> AnyPublisher<T, Error> {
        performRequest(endpoint)
            .map(\.data)
            .decode(type: dto, decoder: decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    public func request(_ endpoint: Endpoint) -> AnyPublisher<Void, Error> {
        performRequest(endpoint)
            .map { _ in return }
            .eraseToAnyPublisher()
    }
}

private extension BaseRemoteDataSource {
    func performRequest(_ endpoint: Endpoint) -> AnyPublisher<DataResponse, Error> {
        return client.requestPublisher(endpoint)
            .retry(maxRetryCount)
            .timeout(RunLoop.SchedulerTimeType.Stride(endpoint.timeout), scheduler: RunLoop.main)
            .mapError {
                if case let .statusCode(response) = $0,
                   let httpResponse = response.response as? HTTPURLResponse {
                    return endpoint.errorMapper?[httpResponse.statusCode] ?? $0 as Error
                }
                return $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
