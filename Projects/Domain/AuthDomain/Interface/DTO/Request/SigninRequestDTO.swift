import Foundation

public struct SigninRequestDTO: Encodable {
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }

    public let email: String
    public let password: String
}
