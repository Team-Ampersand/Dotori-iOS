import BaseDomainInterface
import BaseFeature
import DateUtility
import DesignSystem
import MSGLayout
import NoticeDomainInterface
import UIKit

final class NoticeCell: BaseTableViewCell<NoticeModel> {
    private let signatureColorView = UIView()
        .set(\.backgroundColor, .blue)
        .set(\.cornerRadius, 6)
        .set(\.clipsToBounds, true)
    private let authorLabel = DotoriLabel(font: .smalltitle)
    private let dateLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private let titleLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
        .set(\.numberOfLines, 1)
    private let contentLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
        .set(\.numberOfLines, 2)
    private lazy var contentStackView = VStackView(spacing: 8) {
        HStackView(spacing: 4) {
            signatureColorView
                .width(12)
                .height(12)
            
            authorLabel
            
            SpacerView()
            
            dateLabel
        }
        
        VStackView(spacing: 2) {
            titleLabel
            
            contentLabel
        }
    }
        .margin(.init(top: 12, left: 16, bottom: 12, right: 16))
        .set(\.backgroundColor, .dotori(.neutral(.n50)))
        .set(\.cornerRadius, 8)

    override func setLayout() {
        MSGLayout.stackedLayout(self.contentView) {
            contentStackView
        }
        .margin(.init(top: 6, left: 20, bottom: 6, right: 20))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentStackView.layer.borderColor = selected ? UIColor.dotori(.primary(.p10)).cgColor : UIColor.clear.cgColor
        self.contentStackView.layer.borderWidth = selected ? 2 : 0
    }

    override func configureView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }

    override func adapt(model: NoticeModel) {
        signatureColorView.backgroundColor = model.roles.toSignatureColor
        authorLabel.text = model.roles.toAuthorString
        dateLabel.text = model.createdTime.toStringWithCustomFormat("yyyy.MM.dd")
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
}

private extension UserRoleType {
    var toAuthorString: String {
        switch self {
        case .admin: return "사감선생님"
        case .councillor: return "기숙사자치위원회"
        case .developer: return "도토리"
        case .member: return "학생"
        }
    }

    var toSignatureColor: UIColor {
        switch self {
        case .admin: return .dotori(.sub(.yellow))
        case .member: return .dotori(.neutral(.n20))
        case .councillor: return .dotori(.sub(.red))
        case .developer: return .dotori(.primary(.p10))
        }
    }
}
