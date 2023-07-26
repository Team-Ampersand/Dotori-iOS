import BaseDomainInterface
import BaseFeature
import Combine
import DesignSystem
import MSGLayout
import MassageDomainInterface
import UIKit

final class MassageCell: BaseTableViewCell<MassageRankModel> {
    private let appliedStudentCardView = AppliedStudentCardView()
    private var subscription = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.subscription.removeAll()
    }

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

    func setUserRole(userRole: UserRoleType) {
        appliedStudentCardView.setIsHiddenAttendanceCheckBox(userRole == .member)
    }
}
