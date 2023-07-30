import Anim
import BaseFeatureInterface
import Combine
import Configure
import DesignSystem
import UIKit

/**
 addView() 메서드를 재정의할 때 꼭 super.addView()를 호출해주세요 !
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

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    open override func viewDidLoad() {
        bindAction()
        bindState()
        super.viewDidLoad()
    }

    open func bindState() {}

    open func bindAction() {}
}
