import Foundation

public enum UserRoleType: String, Decodable {
    case member = "ROLE_MEMBER"
    case councillor = "ROLE_COUNCILLOR"
    case developer = "ROLE_DEVELOPER"
}
