import BaseFeature
import CombineUtility
import Configure
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import UIKit
import UtilityModule
import GAuthSignin

final class SigninViewController: BaseStoredViewController<SigninStore> {
    private let dotoriLogoImageView = UIImageView()
        .set(
            \.image,
            .Dotori.dotoriSigninLogo
                .withRenderingMode(.alwaysTemplate)
                .withTintColor(.dotori(.primary(.p10)))
                .resize(width: 182, height: 41)
        )
    private let signinButton = GAuthButton(
        auth: .signin,
        color: .colored,
        rounded: .default
    )

    override func addView() {
        view.addSubviews {
            dotoriLogoImageView
            signinButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            dotoriLogoImageView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(20))
                .height(41)

            signinButton.layout
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
                .bottom(.toSuperview(), .equal(-60))
                .height(50)
        }
    }

    override func configureViewController() {
        self.view.backgroundColor = .dotori(.background(.card))
    }

    override func configureNavigation() {
        self.navigationItem.title = L10n.Signin.loginNavigationTitle
    }

    override func bindAction() {
        signinButton.tapPublisher
            .map { Store.Action.signinButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }
}
