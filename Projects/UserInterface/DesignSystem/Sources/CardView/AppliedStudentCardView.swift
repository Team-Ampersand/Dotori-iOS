import Combine
import MSGLayout
import Nuke
import UIKit

public struct AppliedStudentViewModel: Equatable {
    public let rank: Int
    public let name: String
    public let gender: Gender
    public let stuNum: String
    public let isChecked: Bool
    public let profileImage: String?

    public enum Gender {
        case man
        case woman
    }

    public init(
        rank: Int,
        name: String,
        gender: Gender,
        stuNum: String,
        isChecked: Bool,
        profileImage: String?
    ) {
        self.rank = rank
        self.name = name
        self.gender = gender
        self.stuNum = stuNum
        self.isChecked = isChecked
        self.profileImage = profileImage
    }
}

public protocol AppliedStudentCardViewActionProtocol {
    var attendanceCheckBoxPublisher: AnyPublisher<Bool, Never> { get }
}

public final class AppliedStudentCardView: UIView {
    private var imageTask: Task<Void, Error>?
    private let rankLabel = DotoriLabel(textColor: .neutral(.n20), font: .caption)
    private let attendanceCheckBox = DotoriCheckBox()
        .set(\.isHidden, true)
    private let userImageView = DotoriIconView(
        size: .custom(.init(width: 64, height: 64)),
        image: .Dotori.personRectangle
    )
    .set(\.cornerRadius, 8)
    .set(\.clipsToBounds, true)
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
        self.rankLabel.text = "\(viewModel.rank)"
        self.nameLabel.text = viewModel.name
        self.genderImageView.image = (viewModel.gender == .man ? UIImage.Dotori.men : .Dotori.women)
            .withTintColor(.dotori(.neutral(.n10)), renderingMode: .alwaysOriginal)
        self.stuNumLabel.text = viewModel.stuNum
        self.attendanceCheckBox.isChecked = viewModel.isChecked

        guard let profileImageURL = viewModel.profileImage,
              let imageURL = URL(string: profileImageURL)
        else {
            self.userImageView.image = .Dotori.personRectangle
            return
        }

        let request = ImageRequest(
            url: imageURL,
            priority: .high
        )

        imageTask = Task.detached {
            let image = try await ImagePipeline.shared.image(for: request)
            guard !Task.isCancelled else { return }
            await MainActor.run {
                self.userImageView.image = image
            }
        }
    }

    public func setIsHiddenAttendanceCheckBox(_ isHidden: Bool) {
        attendanceCheckBox.isHidden = isHidden
    }

    public func cancelImageDownload() {
        imageTask?.cancel()
        imageTask = nil
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
