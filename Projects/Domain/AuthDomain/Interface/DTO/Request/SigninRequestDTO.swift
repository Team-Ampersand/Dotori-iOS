import Foundation

public struct SigninRequestDTO: Encodable {
    public init(code: String) {
        self.code = code
    }

    public let code: String
}
