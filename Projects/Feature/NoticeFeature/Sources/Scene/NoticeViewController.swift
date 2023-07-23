import BaseFeature
import Combine
import CombineUtility
import DesignSystem
import GlobalThirdPartyLibrary
import Localization
import MSGLayout
import NoticeDomainInterface
import UIKit
import UIKitUtil

final class NoticeViewController: BaseViewController<NoticeStore> {
    private enum Metric {
        static let horizontalPadding: CGFloat = 20
        static let spacing: CGFloat = 12
    }
    private let dotoriBarButton = DotoriBarButtonItem()
    private let entireTitleLabel = DotoriLabel(L10n.Notice.entireTitle, font: .subtitle1)
    private let editButton = DotoriOutlineButton(text: "편집")
        .set(\.contentEdgeInsets, .init(top: 7.5, left: 13.5, bottom: 7.5, right: 13.5))
    private let writeOrRemoveButton = DotoriTextButton("+ 작성")
    private lazy var headerStackView = HStackView(spacing: 8) {
        entireTitleLabel

        SpacerView()

        editButton

        writeOrRemoveButton
    }
    private let noticeTableView = UITableView()
        .set(\.backgroundColor, .clear)
        .set(\.separatorStyle, .none)
        .set(\.sectionHeaderTopPadding, 0)
        .set(\.allowsMultipleSelection, true)
        .then {
            $0.register(cellType: NoticeCell.self)
        }
    private lazy var noticeTableAdapter = TableViewAdapter<GenericSectionModel<NoticeModel>>(
        tableView: noticeTableView
    ) { tableView, indexPath, notice in
        let cell: NoticeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: notice)
        return cell
    } viewForHeaderInSection: { [store] _, index in
        let sectionTitle = store.currentState.noticeSectionList[index].section
        return NoticeSectionLabel(title: sectionTitle)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editButton.cornerRadius = editButton.frame.height / 2
        writeOrRemoveButton.cornerRadius = writeOrRemoveButton.frame.height / 2
    }

    override func addView() {
        view.addSubviews {
            headerStackView
            noticeTableView
        }
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            headerStackView.layout
                .top(.to(view.safeAreaLayoutGuide), .equal(13))
                .horizontal(.toSuperview(), .equal(Metric.horizontalPadding))

            noticeTableView.layout
                .top(.to(entireTitleLabel).bottom, .equal(24))
                .horizontal(.toSuperview())
                .bottom(.to(view.safeAreaLayoutGuide))
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(dotoriBarButton, animated: true)
        self.view.backgroundColor = .dotori(.background(.card))
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        editButton.tapPublisher
            .map { Store.Action.editButtonDidTap }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.noticeSectionList)
            .map { noticeSection in
                noticeSection.map { _, noticeList in
                    GenericSectionModel(items: noticeList)
                }
            }
            .sink(receiveValue: noticeTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map { $0.currentUserRole != .member && $0.isEditingMode }
            .assign(to: \.allowsSelection, on: noticeTableView)
            .store(in: &subscription)

        sharedState
            .map(\.currentUserRole)
            .map { $0 == .member }
            .sink { [editButton, writeOrRemoveButton] isMember in
                editButton.isHidden = isMember
                writeOrRemoveButton.isHidden = isMember
            }
            .store(in: &subscription)

        sharedState
            .map(\.isEditingMode)
            .map { $0 ? "취소" : "편집" }
            .sink(with: editButton, receiveValue: { editButton, title in
                editButton.setTitle(title, for: .normal)
            })
            .store(in: &subscription)

        sharedState
            .map(\.isEditingMode)
            .sink(receiveValue: { [weak self] isEditingMode in
                self?.transformWriteOrRemoveButton(isEditMode: isEditingMode)
            })
            .store(in: &subscription)
    }
}

private extension NoticeViewController {
    func transformWriteOrRemoveButton(isEditMode: Bool) {
        let title = isEditMode ? "삭제" : "+ 작성"
        let titleColor: UIColor = isEditMode ? .dotori(.system(.error)) : .dotori(.sub(.white))
        let backgroundColor = isEditMode ? UIColor.clear : .dotori(.primary(.p10))
        let highlightedBackgroundColor = isEditMode
        ? backgroundColor.withAlphaComponent(0.1)
        : backgroundColor.withAlphaComponent(0.8)
        let borderColor = isEditMode ? UIColor.dotori(.system(.error)).cgColor : UIColor.clear.cgColor
        let contentInsets = isEditMode
        ? UIEdgeInsets(top: 7.5, left: 13.5, bottom: 7.5, right: 13.5)
        : .init(top: 7.5, left: 15.5, bottom: 7.5, right: 15.5)

        self.writeOrRemoveButton.setTitle(title, for: .normal)
        self.writeOrRemoveButton.setTitleColor(titleColor, for: .normal)
        self.writeOrRemoveButton.setTitleColor(titleColor, for: .highlighted)
        self.writeOrRemoveButton.setBackgroundColor(backgroundColor, for: .normal)
        self.writeOrRemoveButton.setBackgroundColor(highlightedBackgroundColor, for: .highlighted)
        self.writeOrRemoveButton.layer.borderColor = borderColor
        self.writeOrRemoveButton.layer.borderWidth = 1
        self.writeOrRemoveButton.clipsToBounds = true
        self.writeOrRemoveButton.setContentInsets(insets: contentInsets)
    }
}
