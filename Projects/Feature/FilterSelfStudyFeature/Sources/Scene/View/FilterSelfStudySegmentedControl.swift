import BaseFeature
import Combine
import DesignSystem
import MSGLayout
import UIKit

protocol FilterSelfStudySegmentedControlActionProtocol {
    var indexDidChangedPublisher: AnyPublisher<Int?, Never> { get }
}

final class FilterSelfStudySegmentedControl: BaseView {
    private let titleLabel = DotoriLabel(font: .smalltitle)
    private let buttonStackView = HStackView(spacing: 8) {
        [UIView]()
    }.distribution(.fillEqually)
    private let fullGrid = 4
    private let items: [String]
    private let indexSubject = CurrentValueSubject<Int?, Never>(nil)
    private var subscription = Set<AnyCancellable>()

    init(title: String, items: [String]) {
        self.items = items
        super.init()
        self.titleLabel.text = title
        self.buttonStackView.addArrangedSubviews(
            views: items.enumerated().map { makeUnselectedButton(index: $0, title: $1) }
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setLayout() {
        MSGLayout.stackedLayout(self, spacing: 8) {
            titleLabel

            buttonStackView
        }
    }
}

extension FilterSelfStudySegmentedControl: FilterSelfStudySegmentedControlActionProtocol {
    var indexDidChangedPublisher: AnyPublisher<Int?, Never> {
        indexSubject.eraseToAnyPublisher()
    }
}

private extension FilterSelfStudySegmentedControl {
    func updateSelectedIndex(index: Int?) {
        self.subscription.removeAll()
        let buttons = self.items.enumerated().map {
            index == $0
            ? makeSelectedButton(index: $0, title: $1)
            : makeUnselectedButton(index: $0, title: $1)
        }
        self.buttonStackView.removeAllChildren()
        self.buttonStackView.addArrangedSubviews(views: buttons)
    }

    func makeUnselectedButton(index: Int, title: String) -> UIButton {
        let button = DotoriOutlineButton(text: title)
            .set(\.contentEdgeInsets, .vertical(8.5))
        button.tapPublisher
            .map { index }
            .sink(with: self, receiveValue: { owner, index in
                owner.updateSelectedIndex(index: index)
            })
            .store(in: &subscription)
        return button
    }

    func makeSelectedButton(index: Int, title: String) -> UIButton {
        let button = DotoriButton(text: title)
            .set(\.contentEdgeInsets, .vertical(8.5))
        button.tapPublisher
            .map { nil }
            .sink(with: self, receiveValue: { owner, index in
                owner.updateSelectedIndex(index: index)
            })
            .store(in: &subscription)
        return button
    }
}
