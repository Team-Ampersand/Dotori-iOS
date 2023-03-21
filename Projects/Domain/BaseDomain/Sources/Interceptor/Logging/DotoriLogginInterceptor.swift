import Foundation
import Emdpoint

#if DEV || STAGE
// swiftlint: disable line_length
public struct DotoriLoggingInterceptor: InterceptorType {
    public init() {}
    public func willRequest(_ request: URLRequest, endpoint: EndpointType) {
        let url = request.description
        let method = request.httpMethod ?? "unknown method"
        var log = "----------------------------------------------------\n\n[\(method)] \(url)\n\n----------------------------------------------------\n"
        log.append("API: \(endpoint)\n")
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }
        if let body = request.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        log.append("------------------- END \(method) --------------------------\n")
        print(log)
    }

    public func didReceive(
        _ result: Result<DataResponse, EmdpointError>,
        endpoint: EndpointType
    ) {
        switch result {
        case let .success(response):
            onSuceed(response, endpoint: endpoint, isFromError: false)
        case let .failure(error):
            onFail(error, endpoint: endpoint)
        }
    }

    func onSuceed(
        _ response: DataResponse,
        endpoint: EndpointType,
        isFromError: Bool
    ) {
        let request = response.request
        let url = request.url?.absoluteString ?? "nil"
        let statusCode = (response.response as? HTTPURLResponse)?.statusCode ?? 999
        var log = "------------------- 네트워크 통신 성공 -------------------"
        log.append("\n[\(statusCode)] \(url)\n----------------------------------------------------\n")
        log.append("API: \(endpoint)\n")
        (response.response as? HTTPURLResponse)?.allHeaderFields.forEach {
            log.append("\($0): \($1)\n")
        }
        if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
            log.append("\(reString)\n")
        }
        log.append("------------------- END HTTP (\(response.data.count)-byte body) -------------------\n")
        print(log)
    }

    func onFail(_ error: EmdpointError, endpoint: EndpointType) {
        if let resopnse = error.response {
            onSuceed(resopnse, endpoint: endpoint, isFromError: true)
            return
        }
        var log = "네트워크 통신 실패"
        log.append("<-- \(error.errorCode) \(endpoint)\n")
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP\n")
        print(log)
    }
}

#endif
