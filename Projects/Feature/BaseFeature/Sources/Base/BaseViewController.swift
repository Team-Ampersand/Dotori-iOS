import Combine
import DesignSystem
import UIKit

open class BaseViewController:
    UIViewController,
    HasCancellableBag,
    AddViewable,
    SetLayoutable,
    ViewControllerConfigurable,
    NavigationConfigurable {

    // MARK: - Properties

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    private let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    private let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    public var subscription = Set<AnyCancellable>()

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dotori(.background(.bg))
        addView()
        setLayout()
        configureViewController()
        configureNavigation()
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

    open func addView() {}

    open func setLayout() {}

    open func configureViewController() {}

    open func configureNavigation() {}
}

// MARK: - LifeCyclePublishable

extension BaseViewController: LifeCyclePublishable {
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
