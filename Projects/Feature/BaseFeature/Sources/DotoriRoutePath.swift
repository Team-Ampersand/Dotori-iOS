import Moordinator

public enum DotoriRoutePath: RoutePath {
    case splash
    case signin
    case signup
    case findID
    case renewalPassword
    case main
}

public extension RoutePath {
    var asDotori: DotoriRoutePath? {
        self as? DotoriRoutePath
    }
}
