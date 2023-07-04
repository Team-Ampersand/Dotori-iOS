import Emdpoint
import Foundation
import KeyValueStoreInterface

public struct DotoriRoleInterceptor: InterceptorType {
    private let keyValueStore: any KeyValueStore

    public init(keyValueStore: any KeyValueStore) {
        self.keyValueStore = keyValueStore
    }

    public func prepare(
        _ request: URLRequest,
        endpoint: EndpointType,
        completion: @escaping (Result<URLRequest, EmdpointError>) -> Void
    ) {
        guard let requestURLString = request.url?.absoluteString,
              requestURLString.contains("<role>"),
              let currentUserRole = keyValueStore.load(key: .userRole) as? String
        else {
            completion(.success(request))
            return
        }
        var newRequest = request
        let newRequestURLString = requestURLString
            .replacingOccurrences(of: "<role>", with: currentUserRole)
        newRequest.url = URL(string: newRequestURLString)

        completion(.success(newRequest))
    }

    public func didReceive(
        _ result: Result<DataResponse, EmdpointError>,
        endpoint: EndpointType
    ) {
        switch result {
        case let .success(res):
            if let roleDTO = try? JSONDecoder().decode(DotoriRoleDTO.self, from: res.data) {
                guard let userRole = roleDTO.roles.first else { return }
                keyValueStore.save(key: .userRole, value: userRole)
            }

        default:
            break
        }
    }
}
