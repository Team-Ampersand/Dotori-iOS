import BaseDomainInterface
import Combine
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
        let sectiondExpected: [SectiondNoticeTuple] = [
            ("2023년 07월", [expected[0]]),
            ("2023년 08월", [expected[1]])
        ]
        fetchNoticeListUseCase.fetchNoticeListReturn = expected

        sut.state.map(\.noticeList).sink { _ in
            expectation.fulfill()
        }
        .store(in: &subscription)

        XCTAssertEqual(fetchNoticeListUseCase.fetchNoticeListCallCount, 0)
        sut.send(.viewWillAppear)

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
}
