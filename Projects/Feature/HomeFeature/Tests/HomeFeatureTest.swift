import BaseFeature
import Combine
import Moordinator
import XCTest
@testable import HomeFeature
@testable import TimerTesting
@testable import SelfStudyDomainTesting
@testable import MassageDomainTesting
@testable import MealDomainTesting
@testable import UserDomainTesting

final class HomeFeatureTests: XCTestCase {
    var repeatableTimer: RepeatableTimerStub!
    var fetchSelfStudyInfoUseCase: FetchSelfStudyInfoUseCaseSpy!
    var fetchMassageInfoUseCase: FetchMassageInfoUseCaseSpy!
    var fetchMealInfoUseCase: FetchMealInfoUseCaseSpy!
    var loadCurrentUserRoleUseCase: LoadCurrentUserRoleUseCaseSpy!
    var applySelfStudyUseCase: ApplySelfStudyUseCaseSpy!
    var cancelSelfStudyUseCase: CancelSelfStudyUseCaseSpy!
    var applyMassageUseCase: ApplyMassageUseCaseSpy!
    var cancelMassageUseCase: CancelMassageUseCaseSpy!
    var sut: HomeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        repeatableTimer = .init()
        fetchSelfStudyInfoUseCase = .init()
        fetchMassageInfoUseCase = .init()
        fetchMealInfoUseCase = .init()
        loadCurrentUserRoleUseCase = .init()
        applySelfStudyUseCase = .init()
        cancelSelfStudyUseCase = .init()
        applyMassageUseCase = .init()
        cancelMassageUseCase = .init()
        sut = .init(
            repeatableTimer: repeatableTimer,
            fetchSelfStudyInfoUseCase: fetchSelfStudyInfoUseCase,
            fetchMassageInfoUseCase: fetchMassageInfoUseCase,
            fetchMealInfoUseCase: fetchMealInfoUseCase,
            loadCurrentUserRoleUseCase: loadCurrentUserRoleUseCase,
            applySelfStudyUseCase: applySelfStudyUseCase,
            cancelSelfStudyUseCase: cancelSelfStudyUseCase,
            applyMassageUseCase: applyMassageUseCase,
            cancelMassageUseCase: cancelMassageUseCase
        )
        subscription = .init()
    }

    override func tearDown() {
        repeatableTimer = nil
        fetchSelfStudyInfoUseCase = nil
        fetchMassageInfoUseCase = nil
        fetchMealInfoUseCase = nil
        loadCurrentUserRoleUseCase = nil
        applySelfStudyUseCase = nil
        cancelSelfStudyUseCase = nil
        applyMassageUseCase = nil
        cancelMassageUseCase = nil
        sut = nil
        subscription = nil
    }

    func testViewDidLoad() {
        let checkDate = Date()
        repeatableTimer.repeatPublisherClosure = { _, _, _ in
            Just(checkDate)
                .eraseToAnyPublisher()
        }

        let expectation = XCTestExpectation(description: "Asd")
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
