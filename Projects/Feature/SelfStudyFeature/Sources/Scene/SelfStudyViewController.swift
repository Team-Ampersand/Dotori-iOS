import BaseFeature
import DesignSystem
import UIKit
import UIKitUtil

final class SelfStudyViewController: BaseViewController<SelfStudyStore> {
    private let dotoriNavigationBarLabel = DotoriNavigationBarLabel(text: "자습신청")
    private let filterBarButton = UIBarButtonItem(
        image: .Dotori.filter.tintColor(color: .dotori(.neutral(.n20))),
        style: .done,
        target: nil,
        action: nil
    )

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButton(filterBarButton, animated: true)
    }
}
