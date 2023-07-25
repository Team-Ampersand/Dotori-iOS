import Anim
import Combine
import Configure
import DesignSystem
import UIKit

/**
 addView() 메서드를 재정의할 때 꼭 super.addView()를 호출해주세요 !
 */
open class BaseModalViewController: BaseViewController {

    // MARK: - Properties

    public var contentView = UIView()
        .set(\.alpha, 0)

    // MARK: - LifeCycle

    open override func viewDidLoad() {
        if UITraitCollection.current.userInterfaceStyle == .light {
            view.backgroundColor = .init(red: 0.02, green: 0.03, blue: 0.17, alpha: 0.45)
        } else {
            view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.45)
        }
        super.viewDidLoad()
    }


    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modalAnimation()
    }

    open override func addView() {
        view.addSubview(contentView)
    }

    /**
     해당 method는 viewWillAppear에 실행됩니다
     */
    open func modalAnimation() {
        contentView.anim(anim: .concurrent([
            .fadeIn(0.2),
            .dotoriDialog()
        ]))
    }
}
