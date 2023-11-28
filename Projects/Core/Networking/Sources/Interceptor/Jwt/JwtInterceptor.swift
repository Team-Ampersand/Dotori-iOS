import DateUtility
import Emdpoint
import Foundation
import JwtStoreInterface
import NetworkingInterface

public struct JwtInterceptor: InterceptorType {
    private let jwtStore: any JwtStore

    public init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    public func prepare(
        _ request: URLRequest,
        endpoint: EndpointType,
        completion: @escaping (Result<URLRequest, EmdpointError>) -> Void
    ) {
        let newEndpoint = (endpoint as? AnyEndpoint)?.endpoint ?? endpoint
        guard let jwtTokenType = (newEndpoint as? JwtAuthorizable)?.jwtTokenType,
              jwtTokenType != .none
        else {
            completion(.success(request))
            return
        }
        var req = request
        let token = getToken(jwtTokenType: jwtTokenType)
        req.setValue(token, forHTTPHeaderField: jwtTokenType.rawValue)
        if checkTokenIsExpired() {
            reissueToken(req, jwtType: jwtTokenType, completion: completion)
        } else {
            completion(.success(req))
        }
    }

    public func didReceive(
        _ result: Result<DataResponse, EmdpointError>,
        endpoint: EndpointType
    ) {
        switch result {
        case let .success(res):
            if let tokenDTO = try? JSONDecoder().decode(JwtTokenDTO.self, from: res.data) {
                saveToken(tokenDTO: tokenDTO)
            }

        default:
            break
        }
    }
}

private extension JwtInterceptor {
    func getToken(jwtTokenType: JwtTokenType) -> String {
        switch jwtTokenType {
        case .accessToken:
            return "Bearer \(jwtStore.load(property: .accessToken))"

        case .refreshToken:
            return "Bearer \(jwtStore.load(property: .refreshToken))"

        default:
            return ""
        }
    }

    func saveToken(tokenDTO: JwtTokenDTO) {
        jwtStore.save(property: .accessToken, value: tokenDTO.accessToken)
        jwtStore.save(property: .refreshToken, value: tokenDTO.refreshToken)
        jwtStore.save(property: .accessExp, value: tokenDTO.accessExp)
        jwtStore.save(property: .refreshExp, value: tokenDTO.refreshExp)
    }

    func checkTokenIsExpired() -> Bool {
        let accessExp = jwtStore.load(property: .accessExp)
            .toDateWithCustomFormat("yyyy-MM-dd'T'HH:mm:ss")
        return Date() > accessExp
    }

    func reissueToken(
        _ request: URLRequest,
        jwtType: JwtTokenType,
        completion: @escaping (Result<URLRequest, EmdpointError>) -> Void
    ) {
        #if DEV || STAGE
        let client = EmdpointClient<RefreshEndpoint>(interceptors: [DotoriLoggingInterceptor()])
        #else
        let client = EmdpointClient<RefreshEndpoint>()
        #endif
        let refreshToken = jwtStore.load(property: .refreshToken)
        client.request(.refresh(refreshToken: refreshToken)) { result in
            switch result {
            case let .success(response):
                var request = request
                if let tokenDTO = try? JSONDecoder().decode(JwtTokenDTO.self, from: response.data) {
                    saveToken(tokenDTO: tokenDTO)
                    request.setValue(getToken(jwtTokenType: jwtType), forHTTPHeaderField: jwtType.rawValue)
                }
                completion(.success(request))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
