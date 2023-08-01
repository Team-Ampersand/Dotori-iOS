import Anim
import BaseDomainInterface
import BaseFeature
import CombineUtility
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class FilterSelfStudyViewController: BaseStoredModalViewController<FilterSelfStudyStore> {
    private let filterTitleLabel = DotoriLabel(L10n.FilterSelfStudy.filterTitle, font: .subtitle1)
    private let resetButton = DotoriTextButton(
        L10n.FilterSelfStudy.resetButtonTitle,
        textColor: .neutral(.n20),
        font: .body2
    )
    private let nameTextField = DotoriIconTextField(
        placeholder: L10n.FilterSelfStudy.enterNamePlaceholder,
        icon: .Dotori.search
    )
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)
    private let gradeSegmentedControl = FilterSelfStudySegmentedControl(
        title: L10n.FilterSelfStudy.gradeTitle,
        items: ["1", "2", "3"]
    )
    private let classSegmentedControl = FilterSelfStudySegmentedControl(
        title: L10n.FilterSelfStudy.classTitle,
        items: ["1", "2", "3", "4"]
    )
    private let genderSegmentedControl = FilterSelfStudySegmentedControl(
        title: L10n.FilterSelfStudy.genderTitle,
        items: FilterGenderType.allCases.map(\.display)
    )

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.anim(anim: .concurrent([
            .fadeIn(0.2),
            .moveFromBottom(offset: contentView.frame.height)
        ]))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contentView.anim(anim: .concurrent([
            .fadeIn(0.2),
            .moveFromBottom(offset: contentView.frame.height, reversed: true)
        ]))
    }

    override func setLayout() {
        MSGLayout.stackedLayout(self.view, ignoreSafeArea: true) {
            SpacerView()

            contentView
        }

        MSGLayout.stackedLayout(self.contentView) {
            VStackView(spacing: 32) {
                VStackView(spacing: 16) {
                    HStackView {
                        filterTitleLabel

                        SpacerView()

                        resetButton
                    }

                    nameTextField
                }

                gradeSegmentedControl

                classSegmentedControl

                genderSegmentedControl

                confirmButton
            }
            .margin(.init(top: 32, left: 20, bottom: 8, right: 20))
        }
    }

    override func modalAnimation() {}

    override func bindAction() {
        nameTextField.textPublisher
            .map { $0.isEmpty ? nil : $0 }
            .map(Store.Action.updateName)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        gradeSegmentedControl.indexDidChangedPublisher
            .map(Store.Action.updateGrade)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        classSegmentedControl.indexDidChangedPublisher
            .map(Store.Action.updateClass)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        genderSegmentedControl.indexDidChangedPublisher
            .map(Store.Action.updateGender)
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        confirmButton.tapPublisher
            .map { Store.Action.confirmAction }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        resetButton.tapPublisher
            .map { Store.Action.resetButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        view.tapGesturePublisher()
            .map { _ in Store.Action.dimmedBackgroundDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.name)
            .removeDuplicates()
            .assign(to: \.text, on: nameTextField)
            .store(in: &subscription)

        sharedState
            .map(\.grade)
            .removeDuplicates()
            .map { $0.map { $0 - 1} }
            .sink(with: gradeSegmentedControl, receiveValue: { segmentedControl, grade in
                segmentedControl.updateSelectedIndex(index: grade)
            })
            .store(in: &subscription)

        sharedState
            .map(\.class)
            .removeDuplicates()
            .map { $0.map { $0 - 1 } }
            .sink(with: classSegmentedControl, receiveValue: { segmentedControl, `class` in
                segmentedControl.updateSelectedIndex(index: `class`)
            })
            .store(in: &subscription)

        sharedState
            .map(\.gender)
            .removeDuplicates()
            .map { $0?.toIndex }
            .sink(with: genderSegmentedControl, receiveValue: { segmentedControl, gender in
                segmentedControl.updateSelectedIndex(index: gender)
            })
            .store(in: &subscription)
    }
}
