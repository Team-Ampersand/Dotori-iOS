import Foundation

public enum NetworkingError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case conflict
    case tooManyRequest
    case internalServerError

    public init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest

        case 401:
            self = .unauthorized

        case 403:
            self = .forbidden

        case 404:
            self = .notFound

        case 409:
            self = .conflict

        case 429:
            self = .tooManyRequest

        case 500:
            self = .internalServerError

        default:
            self = .internalServerError
        }
    }
}
