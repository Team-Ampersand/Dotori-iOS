import DesignSystem
import UIKit

final class DesignSystemDemoViewController: UIViewController {
    let button = DotoriOutlineButton(text: "ASD")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dotori(.background(.bg))
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    @objc func buttonTap(_ sender: UIButton) {
        let style = [DotoriToast.Style.success, .error, .warning].randomElement() ?? .success
        DotoriToast.makeToast(text: "Toast", style: style)
    }
}
