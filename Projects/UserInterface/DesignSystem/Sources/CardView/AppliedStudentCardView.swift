import Combine
import MSGLayout
import UIKit

public struct AppliedStudentViewModel: Equatable {
    public let rank: Int
    public let name: String
    public let gender: Gender
    public let stuNum: String
    public let isChecked: Bool

    public enum Gender {
        case man
        case woman
    }

    public init(rank: Int, name: String, gender: Gender, stuNum: String, isChecked: Bool) {
        self.rank = rank
        self.name = name
        self.gender = gender
        self.stuNum = stuNum
        self.isChecked = isChecked
    }
}

public protocol AppliedStudentCardViewActionProtocol {
    var attendanceCheckBoxPublisher: AnyPublisher<Bool, Never> { get }
}

public final class AppliedStudentCardView: UIView {
    private let rankLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private let attendanceCheckBox = DotoriCheckBox()
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

    public init() {
        super.init(frame: .zero)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateContent(
        with viewModel: AppliedStudentViewModel
    ) {
        rankLabel.text = "\(viewModel.rank)"
        nameLabel.text = viewModel.name
        genderImageView.image = (viewModel.gender == .man ? UIImage.Dotori.men : .Dotori.women)
            .withTintColor(.dotori(.neutral(.n10)), renderingMode: .alwaysOriginal)
        stuNumLabel.text = viewModel.stuNum
        attendanceCheckBox.isChecked = viewModel.isChecked
    }

    public func setIsHiddenAttendanceCheckBox(_ isHidden: Bool) {
        attendanceCheckBox.isHidden = isHidden
    }
}

private extension AppliedStudentCardView {
    func configureView() {
        self.addSubviews {
            rankLabel
            attendanceCheckBox
            profileStackView
        }

        MSGLayout.buildLayout {
            rankLabel.layout
                .top(.toSuperview(), .equal(12))
                .leading(.toSuperview(), .equal(16))

            attendanceCheckBox.layout
                .top(.toSuperview(), .equal(12))
                .trailing(.toSuperview(), .equal(-12))
                .size(24)

            profileStackView.layout
                .centerX(.toSuperview())
                .top(.toSuperview(), .equal(28))
                .bottom(.toSuperview(), .equal(-28))
        }

        self.backgroundColor = .dotori(.background(.card))
        self.cornerRadius = 16
        DotoriShadow.cardShadow(card: self)
    }
}

extension AppliedStudentCardView: AppliedStudentCardViewActionProtocol {
    public var attendanceCheckBoxPublisher: AnyPublisher<Bool, Never> {
        attendanceCheckBox.checkBoxDidTapPublisher
    }
}
