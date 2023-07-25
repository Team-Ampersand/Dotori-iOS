import BaseDomainInterface
import BaseFeature
import Combine
import Localization
import Moordinator
import NoticeDomainInterface
import XCTest
@testable import NoticeFeature
@testable import NoticeDomainTesting
@testable import UserDomainTesting

final class NoticeFeatureTests: XCTestCase {
    var fetchNoticeListUseCase: FetchNoticeListUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var sut: NoticeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        fetchNoticeListUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        sut = .init(
            fetchNoticeListUseCase: fetchNoticeListUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase
        )
        subscription = .init()
    }

    override func tearDown() {
        fetchNoticeListUseCase = nil
        loadCurrentUserRoleUseCase = nil
        sut = nil
        subscription = nil
    }

    func test_LoadCurrentUserRole_When_ViewDidLoad() {
        let expectation = XCTestExpectation(description: "viewDidLoad expectation")
        let expected = UserRoleType.developer
        loadCurrentUserRoleUseCase.loadCurrentUserRoleReturn = expected

        XCTAssertEqual(loadCurrentUserRoleUseCase.loadCurrentUserRoleCallCount, 0)
        sut.send(.viewDidLoad)

        XCTAssertEqual(expected, sut.currentState.currentUserRole)
        XCTAssertEqual(loadCurrentUserRoleUseCase.loadCurrentUserRoleCallCount, 1)
    }

    func test_FetchNoticeList_When_ViewWillAppear() {
        let expectation = XCTestExpectation(description: "viewWillAppear expectation")
        expectation.expectedFulfillmentCount = 2

        let todayMonth = DateComponents(
            calendar: .init(identifier: .iso8601),
            year: 2023,
            month: 7,
            day: 23
        ).date!
        let nextMonth = todayMonth.addingTimeInterval(86400 * 31)
        let expected = [
            NoticeModel(id: 1, title: "title", content: "content", roles: .councillor, createdTime: todayMonth),
            NoticeModel(id: 2, title: "title2", content: "conten2t", roles: .developer, createdTime: nextMonth)
        ]
        #warning("뭔가가 뭔가인 이 DateFormatting 방식 변경")
        let sectiondExpected: [SectiondNoticeTuple] = [
            (todayMonth.toStringWithCustomFormat(L10n.Notice.noticeSectionDateFormat), [expected[0]]),
            (nextMonth.toStringWithCustomFormat(L10n.Notice.noticeSectionDateFormat), [expected[1]])
        ]
        fetchNoticeListUseCase.fetchNoticeListReturn = expected

        sut.state.map(\.noticeList).removeDuplicates().sink { _ in
            expectation.fulfill()
        }
        .store(in: &subscription)

        XCTAssertEqual(fetchNoticeListUseCase.fetchNoticeListCallCount, 0)
        sut.send(.fetchNoticeList)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(expected, sut.currentState.noticeList)

        XCTAssertEqual(sectiondExpected[0].section, sut.currentState.noticeSectionList[0].section)
        XCTAssertEqual(sectiondExpected[0].noticeList, sut.currentState.noticeSectionList[0].noticeList)
        XCTAssertEqual(sectiondExpected[1].section, sut.currentState.noticeSectionList[1].section)
        XCTAssertEqual(sectiondExpected[1].noticeList, sut.currentState.noticeSectionList[1].noticeList)

        XCTAssertEqual(fetchNoticeListUseCase.fetchNoticeListCallCount, 1)
    }

    func test_ToggleIsEditing_When_EditButtonDidTap() {
        XCTAssertEqual(sut.currentState.isEditingMode, false)

        sut.send(.editButtonDidTap)
        XCTAssertEqual(sut.currentState.isEditingMode, true)

        sut.send(.editButtonDidTap)
        XCTAssertEqual(sut.currentState.isEditingMode, false)

        sut.send(.editButtonDidTap)
        XCTAssertEqual(sut.currentState.isEditingMode, true)
    }

    func test_RouteNoticeDetail_When_NoticeDidTap_And_IsEditingFalse() {
        let expectedNoticeID = 1
        XCTAssertEqual(sut.currentState.isEditingMode, false)
        let expectation = XCTestExpectation(description: "route expectation")

        var latestRoutePath: RoutePath?
        sut.route.sink { routePath in
            latestRoutePath = routePath
            expectation.fulfill()
        }
        .store(in: &subscription)

        sut.send(.noticeDidTap(expectedNoticeID))

        wait(for: [expectation], timeout: 1.0)
        guard
            let latestRoutePath = latestRoutePath?.asDotori,
            case let .noticeDetail(noticeID) = latestRoutePath,
            noticeID == expectedNoticeID
        else {
            XCTFail("latestRoutePath is not DotoriRoutePath.noticeDetail")
            return
        }
    }

    func test_InsertSelectedNotice_When_NoticeDidTap_And_IsEditingTrue() {
        sut.send(.editButtonDidTap)
        XCTAssertEqual(sut.currentState.isEditingMode, true)

        let noticeIDOne = 1
        sut.send(.noticeDidTap(noticeIDOne))

        XCTAssertEqual([noticeIDOne], sut.currentState.selectedNotice)

        let noticeIDTwo = 2
        sut.send(.noticeDidTap(noticeIDTwo))
        XCTAssertEqual([noticeIDOne, noticeIDTwo], sut.currentState.selectedNotice)

        sut.send(.noticeDidTap(noticeIDOne))
        XCTAssertEqual([noticeIDTwo], sut.currentState.selectedNotice)

        sut.send(.noticeDidTap(noticeIDOne))
        XCTAssertEqual([noticeIDOne, noticeIDTwo], sut.currentState.selectedNotice)

        sut.send(.editButtonDidTap)
        XCTAssertEqual([], sut.currentState.selectedNotice)
    }
}
