import BaseFeature
import DesignSystem
import CombineUtility
import GlobalThirdPartyLibrary
import MSGLayout
import Then
import UtilityModule
import UIKit

final class SigninViewController: BaseViewController<SigninStore> {
    private let dotoriLogoImageView = UIImageView().then {
        $0.image = .dotoriSigninLogo
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(.dotori(.primary(.p10)))
            .resize(width: 182, height: 41)
    }
    private let emailTextField = DotoriIconTextField(placeholder: "이메일", icon: .person)
    private let passwordTextField = DotoriIconTextField(placeholder: "비밀번호", icon: .lock).then {
        $0.isSecureTextEntry = true
    }
    private let renewalPasswordButton = DotoriTextButton(
        text: "비밀번호 찾기",
        color: .dotori(.neutral(.n20)),
        font: .dotori(.body2)
    )
    private let signinButton = DotoriButton(text: "로그인")
    private let signupButton = DotoriTextButton(
        text: "Dotori가 처음이라면? 회원가입",
        color: .dotori(.neutral(.n20)),
        font: .dotori(.body2)
    ).then {
        let signupString = NSMutableAttributedString(string: $0.titleLabel?.text ?? "")
        signupString.setColorForText(
            textToFind: "회원가입",
            withColor: .dotori(.primary(.p10))
        )
        $0.setAttributedTitle(signupString, for: .normal)
    }

    override func addView() {
        view.addSubviews {
            dotoriLogoImageView
            emailTextField
            passwordTextField
            renewalPasswordButton
            signinButton
            signupButton
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            dotoriLogoImageView.layout
                .centerX(.toSuperview())
                .top(.to(view.safeAreaLayoutGuide).top, .equal(20))
                .height(41)

            emailTextField.layout
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
                .top(.to(dotoriLogoImageView).bottom, .equal(30))

            passwordTextField.layout
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
                .top(.to(emailTextField).bottom, .equal(8))

            renewalPasswordButton.layout
                .trailing(.to(passwordTextField).trailing)
                .top(.to(passwordTextField).bottom, .equal(8))

            signinButton.layout
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
                .top(.to(renewalPasswordButton).bottom, .equal(32))

            signupButton.layout
                .centerX(.toSuperview())
                .top(.to(signinButton).bottom, .equal(16))
        }
    }

    override func configureNavigation() {
        self.navigationItem.title = "로그인"
    }

    override func bindAction() {
        emailTextField.textPublisher
            .sink(with: store, receiveValue: { store, email in
                store.process(.updateEmail(email))
            })
            .store(in: &bag)

        passwordTextField.textPublisher
            .sink(with: store, receiveValue: { store, password in
                store.process(.updatePassword(password))
            })
            .store(in: &bag)

        signupButton.tapPublisher
            .sink(with: store, receiveValue: { store, _ in
                store.process(.signupButtonDidTap)
            })
            .store(in: &bag)

        renewalPasswordButton.tapPublisher
            .sink(with: store, receiveValue: { store, _ in
                store.process(.renewalPasswordButtonDidTap)
            })
            .store(in: &bag)

        signinButton.tapPublisher
            .sink(with: store, receiveValue: { store, _ in
                store.process(.signinButtonDidTap)
            })
            .store(in: &bag)
    }
}
