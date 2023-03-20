import Foundation
import Emdpoint

#if DEBUG
// swiftlint: disable line_length
public final class DotoriLoggingPlugin: InterceptorType {
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

    public func didReceive(_ result: Result<DataResponse, Error>, endpoint: EndpointType) {
        
    }

//    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
//        switch result {
//        case let .success(response):
//            onSuceed(response, target: target, isFromError: false)
//        case let .failure(error):
//            onFail(error, target: target)
//        }
//    }
//
//    func onSuceed(_ response: DataResponse, target: EndpointType, isFromError: Bool) {
//        let request = response.request
//        let url = request?.url?.absoluteString ?? "nil"
//        let statusCode = response.statusCode
//        var log = "------------------- 네트워크 통신 성공 -------------------"
//        log.append("\n[\(statusCode)] \(url)\n----------------------------------------------------\n")
//        log.append("API: \(target)\n")
//        response.response?.allHeaderFields.forEach {
//            log.append("\($0): \($1)\n")
//        }
//        if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
//            log.append("\(reString)\n")
//        }
//        log.append("------------------- END HTTP (\(response.data.count)-byte body) -------------------\n")
//        print(log)
//    }
//
//    func onFail(_ error: Error, target: EndpointType) {
//        if let response = error.response {
//            onSuceed(response, target: target, isFromError: true)
//            return
//        }
//        var log = "네트워크 오류"
//        log.append("<-- \(error.errorCode) \(target)\n")
//        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
//        log.append("<-- END HTTP\n")
//        print(log)
//    }
}

#endif
