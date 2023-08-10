import BaseDomainInterface
import BaseFeature
import Combine
import DesignSystem
import MassageDomainInterface
import MSGLayout
import UIKit

final class MassageCell: BaseTableViewCell<MassageRankModel> {
    private let appliedStudentCardView = AppliedStudentCardView()

    override func addView() {
        contentView.addSubviews {
            appliedStudentCardView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            appliedStudentCardView.layout
                .horizontal(.toSuperview(), .equal(20))
                .vertical(.toSuperview(), .equal(12))
        }
    }

    override func configureView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func adapt(model: MassageRankModel) {
        super.adapt(model: model)
        self.appliedStudentCardView.updateContent(
            with: .init(
                rank: model.rank,
                name: model.memberName,
                gender: model.gender == .man ? .man : .woman,
                stuNum: model.stuNum,
                isChecked: false
            )
        )
    }
}
