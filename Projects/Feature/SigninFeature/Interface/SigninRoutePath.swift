import DesignSystem
import Moordinator

public enum SigninRoutePath: RoutePath {
    case signin
    case signup
    case renewalPassword
    case main
    case toast(text: String, style: DotoriToast.Style, duration: DotoriToast.Duration = .short)
}
