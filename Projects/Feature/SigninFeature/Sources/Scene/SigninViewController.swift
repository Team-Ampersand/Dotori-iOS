import BaseFeature
import DesignSystem
import Then
import MSGLayout

final class SigninViewController: BaseViewController<SigninStore> {
    private let dotoriLogoImageView = DotoriIconView().then {
        $0.image = .dotoriSigninLogo
    }
}
