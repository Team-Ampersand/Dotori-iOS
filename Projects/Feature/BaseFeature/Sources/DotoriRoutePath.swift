import Moordinator

public enum DotoriRoutePath: RoutePath {
    case splash
    case signin
    case signup
    case findID
    case renewalPassword
    case main

    // MARK: Home
    case home

    // MARK: Notice
    case notice

    // MARK: SelfStudy
    case selfStudy

    // MARK: Massage
    case massage

    // MARK: Music
    case music
}

public extension RoutePath {
    var asDotori: DotoriRoutePath? {
        self as? DotoriRoutePath
    }
}
