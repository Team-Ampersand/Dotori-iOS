import Emdpoint
import Foundation
import JwtStoreInterface

public struct JwtInterceptor: InterceptorType {
    private let jwtStore: any JwtStore

    public init(jwtStore: any JwtStore) {
        self.jwtStore = jwtStore
    }

    public func prepare(
        _ request: URLRequest,
        endpoint: EndpointType,
        completion: (Result<URLRequest, EmdpointError>) -> Void
    ) {
        guard let jwtTokenType = (endpoint as? JwtAuthorizable)?.jwtTokenType,
              jwtTokenType != .none
        else {
            completion(.success(request))
            return
        }
        var req = request
        let token = getToken(jwtTokenType: jwtTokenType)
        req.addValue(jwtTokenType.rawValue, forHTTPHeaderField: token)
        completion(.success(request))
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
        jwtStore.save(property: .accessExpiresAt, value: tokenDTO.expiresAt)
    }
}
