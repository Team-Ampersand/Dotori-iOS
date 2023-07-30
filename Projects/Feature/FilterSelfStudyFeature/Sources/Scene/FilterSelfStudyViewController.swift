import Anim
import BaseFeature
import Configure
import DesignSystem
import Localization
import MSGLayout
import UIKit

final class FilterSelfStudyViewController: BaseStoredModalViewController<FilterSelfStudyStore> {
    private let filterTitleLabel = DotoriLabel("필터", font: .subtitle1)
    private let resetButton = DotoriTextButton("초기화", textColor: .neutral(.n20), font: .body2)
    private let nameTextField = DotoriIconTextField(placeholder: "이름을 입력해주세요", icon: .Dotori.search)
    private let confirmButton = DotoriButton(text: L10n.Global.confirmButtonTitle)
    private let gradeSegmentedControl = FilterSelfStudySegmentedControl(
        title: "학년",
        items: ["1", "2", "3"]
    )
    private let classSegmentedControl = FilterSelfStudySegmentedControl(
        title: "반",
        items: ["1", "2", "3", "4"]
    )
    private let genderSegmentedControl = FilterSelfStudySegmentedControl(
        title: "성별",
        items: ["남자", "여자"]
    )

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.anim(anim: .concurrent([
            .fadeIn(0.2),
            .moveFromBottom(offset: contentView.frame.height)
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
}
