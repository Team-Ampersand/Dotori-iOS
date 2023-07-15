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

        let actual = try await fetchMealInfoUseCase(date: .init())

        XCTAssertEqual(mealRepository.fetchMealInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
