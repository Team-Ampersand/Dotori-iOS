import BaseFeature
import DesignSystem
import MSGLayout

final class SigninViewController: BaseViewController<SigninStore> {
    private let textField = DotoriSimpleTextField(placeholder: "이메일")

    override func addView() {
        view.addSubviews {
            textField
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            textField.layout
                .centerY(.toSuperview())
                .horizontal(.toSuperview(), .equal(20))
        }
    }

    override func configureViewController() {
        view.backgroundColor = .dotori(.background(.bg))
    }
}
