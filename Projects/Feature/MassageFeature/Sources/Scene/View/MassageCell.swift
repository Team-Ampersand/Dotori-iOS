import BaseDomainInterface
import BaseFeature
import Combine
import DesignSystem
import MSGLayout
import MassageDomainInterface
import UIKit

protocol MassageCellDelegate: AnyObject {
    func massageCheckBoxDidTap(id: Int, isChecked: Bool)
}

final class MassageCell: BaseTableViewCell<Void> {
    weak var delegate: (any MassageCellDelegate)?
    private let appliedStudentCardView = AppliedStudentCardView()
    private var subscription = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindAction()
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

    override func adapt(model: Void) {
        super.adapt(model: model)
//        self.appliedStudentCardView.updateContent(
//            with: .init(
//                rank: model.rank,
//                name: model.memberName,
//                gender: model.gender == .man ? .man : .woman,
//                stuNum: model.stuNum,
//                isChecked: model.selfStudyCheck
//            )
//        )
    }

    func setUserRole(userRole: UserRoleType) {
        appliedStudentCardView.setIsHiddenAttendanceCheckBox(userRole == .member)
    }
}

private extension MassageCell {
    func bindAction() {
//        appliedStudentCardView.attendanceCheckBoxPublisher
//            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
//            .compactMap { [weak self] (checked) -> (Int, Bool)? in
//                guard let id = self?.model?.id else { return nil }
//                return (id, checked)
//            }
//            .sink(with: self, receiveValue: { owner, checked in
//                owner.delegate?.selfStudyCheckBoxDidTap(id: checked.0, isChecked: checked.1)
//            })
//            .store(in: &subscription)
    }
}
