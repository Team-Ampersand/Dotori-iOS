import Foundation

public enum UserRoleType: String, Decodable {
    case admin = "ROLE_ADMIN"
    case member = "ROLE_MEMBER"
    case councillor = "ROLE_COUNCILLOR"
    case developer = "ROLE_DEVELOPER"
}
