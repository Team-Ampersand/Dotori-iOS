import BaseFeature
import CombineUtility
import DesignSystem
import Localization
import MSGLayout
import MusicDomainInterface
import UIKit
import UIKitUtil

final class MusicViewController: BaseStoredViewController<MusicStore> {
    private let musicNavigationBarLabel = DotoriNavigationBarLabel(text: L10n.Music.musicTitle)
    private let calendarBarButton = UIBarButtonItem(
        image: .Dotori.calendar.tintColor(color: .dotori(.neutral(.n20)))
    )
    public let newMusicButton = UIBarButtonItem(
        image: .Dotori.plus.tintColor(color: .dotori(.neutral(.n20)))
    )
    private let musicTableView = UITableView()
        .set(\.backgroundColor, .dotori(.background(.card)))
        .set(\.separatorStyle, .none)
        .set(\.cornerRadius, 16)
        .set(\.sectionHeaderHeight, 0)
        .set(\.contentInset, .init(top: 8, left: 0, bottom: 0, right: 0))
        .set(\.showsVerticalScrollIndicator, false)
        .then {
            $0.register(cellType: MusicCell.self)
        }
    private let musicRefreshControl = UIRefreshControl()
    private lazy var musicTableAdapter = TableViewAdapter<GenericSectionModel<MusicModel>>(
        tableView: musicTableView
    ) { [weak self] tableView, indexPath, item in
        let cell: MusicCell = tableView.dequeueReusableCell(for: indexPath)
        cell.adapt(model: item)
        cell.delegate = self
        return cell
    }
    private let emptyMusicStackView = VStackView(spacing: 8) {
        DotoriIconView(
            size: .custom(.init(width: 120, height: 120)),
            image: .Dotori.music
        )

        DotoriLabel(L10n.Music.emptyMusicTitle, font: .subtitle2)

        DotoriLabel(L10n.Music.proposeMusicTitle, textColor: .neutral(.n20), font: .caption)
    }.alignment(.center)

    override func addView() {
        view.addSubviews {
            musicTableView
            emptyMusicStackView
        }
        musicTableView.refreshControl = musicRefreshControl
    }

    override func setLayout() {
        MSGLayout.buildLayout {
            musicTableView.layout
                .horizontal(.toSuperview(), .equal(20))
                .vertical(.to(view.safeAreaLayoutGuide), .equal(16))

            emptyMusicStackView.layout
                .center(.toSuperview())
        }
    }

    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(musicNavigationBarLabel, animated: true)
        self.navigationItem.setRightBarButtonItems([newMusicButton], animated: true)
        #warning("날짜 선택 구현")
    }

    override func bindAction() {
        viewDidLoadPublisher
            .map { Store.Action.viewDidLoad }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)

        musicRefreshControl.controlPublisher(for: .valueChanged)
            .map { _ in Store.Action.refresh }
            .sink(receiveValue: store.send(_:))
            .store(in: &subscription)
    }

    override func bindState() {
        let sharedState = store.state.share()
            .receive(on: DispatchQueue.main)

        sharedState
            .map(\.musicList)
            .map { [GenericSectionModel(items: $0)] }
            .sink(receiveValue: musicTableAdapter.updateSections(sections:))
            .store(in: &subscription)

        sharedState
            .map(\.isRefreshing)
            .removeDuplicates()
            .sink(with: musicRefreshControl, receiveValue: { refreshControl, isRefreshing in
                isRefreshing ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
            })
            .store(in: &subscription)

        sharedState
            .map(\.musicList)
            .map(\.isEmpty)
            .removeDuplicates()
            .sink(with: emptyMusicStackView, receiveValue: { emptyView, musicListIsEmpty in
                emptyView.isHidden = !musicListIsEmpty
            })
            .store(in: &subscription)
    }
}

extension MusicViewController: MusicCellDelegate {
    func cellMeatballDidTap(model: MusicModel) {
        store.send(.cellMeatballDidTap(music: model))
    }
}
