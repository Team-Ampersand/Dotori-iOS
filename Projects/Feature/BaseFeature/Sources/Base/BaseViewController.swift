import BaseFeatureInterface
import Combine
import DesignSystem
import UIKit

open class BaseViewController:
    UIViewController,
    ViewControllable,
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

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .dotori(.background(.bg))
        addView()
        setLayout()
        configureViewController()
        configureNavigation()
        viewDidLoadSubject.send(())
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send(())
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send(())
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send(())
    }

    override open func viewDidDisappear(_ animated: Bool) {
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
