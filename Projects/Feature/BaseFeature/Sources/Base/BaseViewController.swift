import Combine
import UIKit

open class BaseViewController<VM: BaseViewModel>: UIViewController, BoundsProviable {

    // MARK: - Properties

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    private let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    private let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    public let viewModel: VM
    public var bag = Set<AnyCancellable>()

    // MARK: - Init

    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        configureViewController()
        configureNavigation()
        bind()
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

    // MARK: - UI

    open func addView() {}

    open func setLayout() {}

    open func configureViewController() {}

    open func configureNavigation() {}

    open func bind() {}
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
