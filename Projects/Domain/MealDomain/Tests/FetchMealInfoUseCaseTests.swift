import MealDomainInterface
import XCTest
@testable import MealDomainTesting
@testable import MealDomain

final class FetchMealInfoUseCaseTests: XCTestCase {
    var mealRepository: MealRepositorySpy!
    var fetchMealInfoUseCase: FetchMealInfoUseCaseImpl!

    override func setUp() {
        mealRepository = .init()
        fetchMealInfoUseCase = .init(mealRepository: mealRepository)
    }

    override func tearDown() {
        mealRepository = nil
        fetchMealInfoUseCase = nil
    }

    func testFetchMealInfo() async throws {
        XCTAssertEqual(mealRepository.fetchMealInfoCallCount, 0)
        let expected = [MealInfoEntity(meals: ["밥"], mealType: .breakfast)]
        mealRepository.fetchMealInfoReturn = expected

        let fetchMealInfoMiniature = fetchMealInfoUseCase(date: .init())

        var publishCount = 0
        for try await status in fetchMealInfoMiniature.toAnyPublisher().values {
            switch status {
            case let .loading(local):
                XCTAssertEqual(local, nil)
                XCTAssertEqual(publishCount, 0)
                publishCount += 1

            case let .completed(remote):
                XCTAssertEqual(remote, expected)
                XCTAssertEqual(publishCount, 1)
                publishCount += 1

            default:
                XCTFail("Unexpected enum")
            }
        }

        XCTAssertEqual(mealRepository.fetchMealInfoCallCount, 1)
    }
}
