import Moordinator
import UIKit

public enum DotoriRoutePath: RoutePath {
    // MARK: Global
    case alert(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = []
    )
    case confirmationDialog(
        title: String = "",
        description: String = "",
        confirmAction: () async -> Void
    )
    case dismiss
    case pop

    // MARK: Auth
    case splash
    case signin
    case signup
    case findID
    case renewalPassword
    case main

    // MARK: Home
    case home
    case myInfoActionSheet
    case myViolationList

    // MARK: Notice
    case notice
    case detailNotice(noticeID: Int)

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
