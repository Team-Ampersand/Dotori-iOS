import BaseFeature
import Combine
@testable import HomeFeature
@testable import MassageDomainTesting
@testable import MealDomainTesting
import Moordinator
@testable import SelfStudyDomainTesting
@testable import TimerTesting
@testable import UserDomainTesting
import XCTest

final class HomeFeatureTests: XCTestCase {
    var repeatableTimer: RepeatableTimerStub!
    var fetchProfileImageUseCase: FetchProfileImageUseCaseSpy!
    var fetchSelfStudyInfoUseCase: FetchSelfStudyInfoUseCaseSpy!
    var fetchMassageInfoUseCase: FetchMassageInfoUseCaseSpy!
    var fetchMealInfoUseCase: FetchMealInfoUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var applySelfStudyUseCase: ApplySelfStudyUseCaseSpy!
    var cancelSelfStudyUseCase: CancelSelfStudyUseCaseSpy!
    var modifySelfStudyPersonnelUseCase: ModifySelfStudyPersonnelUseCaseSpy!
    var applyMassageUseCase: ApplyMassageUseCaseSpy!
    var cancelMassageUseCase: CancelMassageUseCaseSpy!
    var modifyMassagePersonnelUseCase: ModifyMassagePersonnelUseCaseSpy!
    var logoutUseCase: LogoutUseCaseSpy!
    var withdrawalUseCase: WithdrawalUseCaseSpy!
    var sut: HomeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        repeatableTimer = .init()
        fetchProfileImageUseCase = .init()
        fetchSelfStudyInfoUseCase = .init()
        fetchMassageInfoUseCase = .init()
        fetchMealInfoUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        applySelfStudyUseCase = .init()
        cancelSelfStudyUseCase = .init()
        modifySelfStudyPersonnelUseCase = .init()
        applyMassageUseCase = .init()
        cancelMassageUseCase = .init()
        modifyMassagePersonnelUseCase = .init()
        logoutUseCase = .init()
        withdrawalUseCase = .init()
        sut = .init(
            repeatableTimer: repeatableTimer,
            fetchProfileImageUseCase: fetchProfileImageUseCase,
            fetchSelfStudyInfoUseCase: fetchSelfStudyInfoUseCase,
            fetchMassageInfoUseCase: fetchMassageInfoUseCase,
            fetchMealInfoUseCase: fetchMealInfoUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            applySelfStudyUseCase: applySelfStudyUseCase,
            cancelSelfStudyUseCase: cancelSelfStudyUseCase,
            modifySelfStudyPersonnelUseCase: modifySelfStudyPersonnelUseCase,
            applyMassageUseCase: applyMassageUseCase,
            cancelMassageUseCase: cancelMassageUseCase,
            modifyMassagePersonnelUseCase: modifyMassagePersonnelUseCase,
            logoutUseCase: logoutUseCase,
            withdrawalUseCase: withdrawalUseCase
        )
        subscription = .init()
    }

    override func tearDown() {
        repeatableTimer = nil
        fetchProfileImageUseCase = nil
        fetchSelfStudyInfoUseCase = nil
        fetchMassageInfoUseCase = nil
        fetchMealInfoUseCase = nil
        loadCurrentUserRoleUseCase = nil
        applySelfStudyUseCase = nil
        cancelSelfStudyUseCase = nil
        modifyMassagePersonnelUseCase = nil
        applyMassageUseCase = nil
        cancelMassageUseCase = nil
        modifyMassagePersonnelUseCase = nil
        logoutUseCase = nil
        withdrawalUseCase = nil
        sut = nil
        subscription = nil
    }

    func testViewDidLoad() {
        let checkDate = Date()
        repeatableTimer.repeatPublisherClosure = { _, _, _ in
            Just(checkDate)
                .eraseToAnyPublisher()
        }

        let expectation = XCTestExpectation(description: "viewDidLoad expectation")
        expectation.expectedFulfillmentCount = 2
        var testTargetDate: Date?

        sut.state.map(\.currentTime).sink {
            testTargetDate = $0
            expectation.fulfill()
        }
        .store(in: &subscription)

        sut.send(.viewDidLoad)
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(checkDate, testTargetDate)
    }

    func testMyInfoBarButtonDidTap() {
        var route: RoutePath = DotoriRoutePath.main
        sut.route.sink {
            route = $0
        }
        .store(in: &subscription)

        sut.send(.myInfoButtonDidTap)

        guard case DotoriRoutePath.alert = route else {
            XCTFail("route not sent 'alert'")
            return
        }
    }
}
