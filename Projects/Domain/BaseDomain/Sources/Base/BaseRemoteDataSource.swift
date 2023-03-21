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
        requestPublisher(endpoint)
            .map(\.data)
            .decode(type: dto, decoder: decoder)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    public func request(_ endpoint: Endpoint) -> AnyPublisher<Void, Error> {
        requestPublisher(endpoint)
            .map { _ in return }
            .eraseToAnyPublisher()
    }

    private func requestPublisher(_ endpoint: Endpoint) -> AnyPublisher<DataResponse, Error> {
        return checkIsEndpointNeedsAuthorization(endpoint) ?
        authorizedRequest(endpoint) :
        defaultRequest(endpoint)
    }
}

private extension BaseRemoteDataSource {
    func defaultRequest(_ endpoint: Endpoint) -> AnyPublisher<DataResponse, Error> {
        client.requestPublisher(endpoint)
            .retry(maxRetryCount)
            .timeout(45, scheduler: RunLoop.main)
            .mapError {
                if case let .underlying(err) = $0,
                   let emdpointError = err as? EmdpointError,
                   case let .statusCode(response) = emdpointError,
                   let httpResponse = response.response as? HTTPURLResponse {
                    return endpoint.errorMapper?[httpResponse.statusCode] ?? $0 as Error
                }
                return $0 as Error
            }
            .eraseToAnyPublisher()
    }

    func authorizedRequest(_ endpoint: Endpoint) -> AnyPublisher<DataResponse, Error> {
        if checkTokenIsExpired() {
            return reissueToken()
                .retry(maxRetryCount)
                .flatMap { self.defaultRequest(endpoint) }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        } else {
            return defaultRequest(endpoint)
                .retry(maxRetryCount)
                .eraseToAnyPublisher()
        }
    }

    func checkTokenIsExpired() -> Bool {
        let expired = jwtStore.load(property: .accessExpiresAt)
            .toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss")
        return Date() > expired
    }

    func checkIsEndpointNeedsAuthorization(_ endpoint: Endpoint) -> Bool {
        endpoint.jwtTokenType == .accessToken
    }

    func reissueToken() -> AnyPublisher<Void, Error> {
        let client = EmdpointClient<RefreshEndpoint>(
            interceptors: [JwtInterceptor(jwtStore: jwtStore)]
        )
        return client.requestPublisher(.refresh)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
