import BaseFeatureInterface
import Moordinator
import UIKit

open class BaseStoredViewController<Store: BaseStore>:
    BaseViewController,
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
