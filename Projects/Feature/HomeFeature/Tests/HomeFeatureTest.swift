import BaseFeature
import Combine
import Moordinator
import XCTest
@testable import HomeFeature
@testable import TimerTesting
@testable import SelfStudyDomainTesting
@testable import MassageDomainTesting
@testable import MealDomainTesting

final class HomeFeatureTests: XCTestCase {
    var repeatableTimer: RepeatableTimerStub!
    var fetchSelfStudyInfoUseCase: FetchSelfStudyInfoUseCaseSpy!
    var fetchMassageInfoUseCase: FetchMassageInfoUseCaseSpy!
    var fetchMealInfoUseCase: FetchMealInfoUseCaseSpy!
    var sut: HomeStore!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        repeatableTimer = .init()
        fetchSelfStudyInfoUseCase = .init()
        fetchMassageInfoUseCase = .init()
        fetchMealInfoUseCase = .init()
        sut = .init(
            repeatableTimer: repeatableTimer,
            fetchSelfStudyInfoUseCase: fetchSelfStudyInfoUseCase,
            fetchMassageInfoUseCase: fetchMassageInfoUseCase,
            fetchMealInfoUseCase: fetchMealInfoUseCase
        )
        subscription = .init()
    }

    override func tearDown() {
        repeatableTimer = nil
        fetchSelfStudyInfoUseCase = nil
        fetchMassageInfoUseCase = nil
        fetchMealInfoUseCase = nil
        sut = nil
        subscription = nil
    }

    func testViewDidLoad() {
        let checkDate = Date()
        repeatableTimer.repeatPublisherClosure = { _, _, _ in
            Just(checkDate)
                .eraseToAnyPublisher()
        }

        var testTargetDate: Date?

        sut.state.map(\.currentTime).sink {
            testTargetDate = $0
        }
        .store(in: &subscription)

        sut.send(.viewDidLoad)

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
