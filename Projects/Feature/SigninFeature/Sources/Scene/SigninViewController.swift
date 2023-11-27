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
    private let dotoriSubTitle = DotoriLabel(
        "광주소프트웨어마이스터고\n기숙사 관리 시스템, DOTORI",
        textColor: .neutral(.n20),
        font: .subtitle2
    )
        .set(\.numberOfLines, 0)
        .set(\.textAlignment, .center)
    private let signinButton = GAuthButton(
        auth: .signin,
        color: .colored,
        rounded: .default
    )

    override func addView() {
        view.addSubviews {
            dotoriLogoImageView
            dotoriSubTitle
            signinButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            dotoriLogoImageView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(200))
                .height(41)

            dotoriSubTitle.layout
                .centerX(.toSuperview())
                .top(.to(dotoriLogoImageView).bottom, .equal(20))

            signinButton.layout
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
                .bottom(.to(view.safeAreaLayoutGuide), .equal(-32))
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
