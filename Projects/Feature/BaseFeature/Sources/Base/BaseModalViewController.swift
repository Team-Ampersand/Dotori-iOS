import Combine
import DesignSystem
import UIKit

/**
 addView() 메서드를 재정의할 때 꼭 super.addView()를 호출해주세요 !
 */
open class BaseModalViewController<Store: BaseStore>:
    UIViewController,
    HasCancellableBag,
    StoredViewControllable,
    AddViewable,
    SetLayoutable,
    ViewControllerConfigurable,
    NavigationConfigurable,
    StoreBindable {

    // MARK: - Properties

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    private let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    private let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    public let store: Store
    public var subscription = Set<AnyCancellable>()
    public var contentView = UIView()

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
        super.viewDidLoad()
        if UITraitCollection.current.userInterfaceStyle == .light {
            view.backgroundColor = .init(red: 0.02, green: 0.03, blue: 0.17, alpha: 0.45)
        } else {
            view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.45)
        }
        addView()
        setLayout()
        configureViewController()
        configureNavigation()
        bindAction()
        bindState()
        viewDidLoadSubject.send(())
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send(())
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send(())
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send(())
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearSubject.send(())
    }

    open func addView() {
        view.addSubview(contentView)
    }

    open func setLayout() {}

    open func configureViewController() {}

    open func configureNavigation() {}

    open func bindState() {}

    open func bindAction() {}
}

// MARK: - LifeCyclePublishable

extension BaseModalViewController: LifeCyclePublishable {
    public var viewDidLoadPublisher: AnyPublisher<Void, Never> {
        viewDidLoadSubject.eraseToAnyPublisher()
    }

    public var viewWillAppearPublisher: AnyPublisher<Void, Never> {
        viewWillAppearSubject.eraseToAnyPublisher()
    }

    public var viewDidAppearPublisher: AnyPublisher<Void, Never> {
        viewDidAppearSubject.eraseToAnyPublisher()
    }

    public var viewWillDisappearPublisher: AnyPublisher<Void, Never> {
        viewWillDisappearSubject.eraseToAnyPublisher()
    }

    public var viewDidDisappearPublisher: AnyPublisher<Void, Never> {
        viewDidDisappearSubject.eraseToAnyPublisher()
    }
}
