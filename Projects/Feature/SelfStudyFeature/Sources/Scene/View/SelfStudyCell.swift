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
    weak var delegate: (any SelfStudyCellDelegate)? = nil
    private let containerView = UIView()
    private let rankLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private let selfStudyCheckBox = DotoriCheckBox()
        .set(\.isHidden, true)
    private let userImageView = DotoriIconView(
        size: .custom(.init(width: 64, height: 64)),
        image: .Dotori.personRectangle
    )
    private let nameLabel = DotoriLabel(textColor: .neutral(.n10), font: .body1)
    private let genderImageView = DotoriIconView(
        size: .custom(.init(width: 16, height: 16)),
        image: .Dotori.men
    )
    private let stuNumLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private lazy var profileStackView = VStackView(spacing: 8) {
        userImageView

        HStackView(spacing: 2) {
            nameLabel

            genderImageView
        }
        .alignment(.center)

        stuNumLabel
    }.alignment(.center)
    private let medalImageView = DotoriIconView(
        size: .custom(.init(width: 56, height: 80)),
        image: nil
    )
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
            containerView
        }
        containerView.addSubviews {
            rankLabel
            selfStudyCheckBox
            profileStackView
            medalImageView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            containerView.layout
                .horizontal(.toSuperview(), .equal(20))
                .vertical(.toSuperview(), .equal(12))

            rankLabel.layout
                .top(.toSuperview(), .equal(12))
                .leading(.toSuperview(), .equal(16))

            selfStudyCheckBox.layout
                .top(.toSuperview(), .equal(12))
                .trailing(.toSuperview(), .equal(-12))
                .size(24)

            profileStackView.layout
                .centerX(.toSuperview())
                .top(.toSuperview(), .equal(28))
                .bottom(.toSuperview(), .equal(-28))

            medalImageView.layout
                .trailing(.toSuperview(), .equal(-8))
                .bottom(.toSuperview(), .equal(20))
        }
    }

    override func configureView() {
        self.containerView.backgroundColor = .dotori(.background(.card))
        self.containerView.cornerRadius = 16
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func adapt(model: SelfStudyRankModel) {
        super.adapt(model: model)
        self.rankLabel.text = "\(model.rank)"
        self.nameLabel.text = model.memberName
        self.genderImageView.image = model.gender == .man ? .Dotori.men : .Dotori.women
        self.stuNumLabel.text = model.stuNum
        self.selfStudyCheckBox.isChecked = model.selfStudyCheck
        self.medalImageView.image = self.rankToImage(rank: model.rank)
    }

    func setUserRole(userRole: UserRoleType) {
        selfStudyCheckBox.isHidden = userRole == .member
    }
}

private extension SelfStudyCell {
    func bindAction() {
        selfStudyCheckBox.checkBoxDidTapPublisher
            .compactMap { [weak self] (checked) -> (Int, Bool)? in
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
