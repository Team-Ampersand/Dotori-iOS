import Anim
import BaseFeatureInterface
import Combine
import Configure
import DesignSystem
import UIKit

/**
 addView() 메서드를 재정의할 때 꼭 super.addView()를 호출해주세요 !
 modalAnimation() 메서드를 재정의하면 화면에 present할 때 애니메이션을 정의할 수 있습니다.
 */
open class BaseStoredModalViewController<Store: BaseStore>:
    BaseModalViewController,
    RoutedViewControllable,
    StoredViewControllable,
    StoreBindable {
    // MARK: - Properties

    public let store: Store

    // MARK: - Init

    public init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override open func viewDidLoad() {
        bindAction()
        bindState()
        super.viewDidLoad()
    }

    open func bindState() {}

    open func bindAction() {}
}
