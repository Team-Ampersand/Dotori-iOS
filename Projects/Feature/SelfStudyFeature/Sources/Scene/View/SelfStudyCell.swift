import BaseDomainInterface
import BaseFeature
import Combine
import DesignSystem
import MSGLayout
import SelfStudyDomainInterface
import UIKit

protocol SelfStudyCellDelegate: AnyObject {
    func selfStudyCheckBoxDidTap(id: Int, isChecked: Bool)
}

final class SelfStudyCell: BaseTableViewCell<SelfStudyRankModel> {
    weak var delegate: (any SelfStudyCellDelegate)?
    private let appliedStudentCardView = AppliedStudentCardView()
    private let medalImageView = DotoriIconView(
        size: .custom(.init(width: 56, height: 80)),
        image: nil
    )
    private var subscription = Set<AnyCancellable>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bindAction()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard model == nil else { return }
        subscription.removeAll()
    }

    override func addView() {
        contentView.addSubviews {
            appliedStudentCardView
        }
        appliedStudentCardView.addSubviews {
            medalImageView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            appliedStudentCardView.layout
                .horizontal(.toSuperview(), .equal(20))
                .vertical(.toSuperview(), .equal(12))

            medalImageView.layout
                .trailing(.toSuperview(), .equal(-8))
                .bottom(.toSuperview(), .equal(20))
        }
    }

    override func configureView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func adapt(model: SelfStudyRankModel) {
        super.adapt(model: model)
        self.appliedStudentCardView.updateContent(
            with: .init(
                rank: model.rank,
                name: model.memberName,
                gender: model.gender == .man ? .man : .woman,
                stuNum: model.stuNum,
                isChecked: model.selfStudyCheck
            )
        )
        self.medalImageView.image = self.rankToImage(rank: model.rank)
    }

    func setUserRole(userRole: UserRoleType) {
        appliedStudentCardView.setIsHiddenAttendanceCheckBox(userRole == .member)
    }
}

private extension SelfStudyCell {
    func bindAction() {
        appliedStudentCardView.attendanceCheckBoxPublisher
            .compactMap { [weak self] checked -> (Int, Bool)? in
                guard let id = self?.model?.id else { return nil }
                return (id, checked)
            }
            .sink(with: self, receiveValue: { owner, checked in
                owner.delegate?.selfStudyCheckBoxDidTap(id: checked.0, isChecked: checked.1)
            })
            .store(in: &subscription)
    }

    func rankToImage(rank: Int) -> UIImage? {
        switch rank {
        case 1: return .Dotori.firstMedal
        case 2: return .Dotori.secondMedal
        case 3: return .Dotori.thirdMedal
        default: return nil
        }
    }
}
