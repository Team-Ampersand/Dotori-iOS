import UIKit

open class BaseView:
    UIView,
    AddViewable,
    SetLayoutable {
    public init() {
        super.init(frame: .zero)
        addView()
        setLayout()
        configure()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func addView() {}
    open func setLayout() {}
    open func configure() {}
}
