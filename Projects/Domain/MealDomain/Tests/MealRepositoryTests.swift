import MealDomainInterface
import XCTest
@testable import MealDomainTesting
@testable import MealDomain

final class MealRepositoryTests: XCTestCase {
    var remoteMealDataSource: RemoteMealDataSourceSpy!
    var sut: MealRepositoryImpl!

    override func setUp() {
        remoteMealDataSource = .init()
        sut = .init(remoteMealDataSource: remoteMealDataSource)
    }

    override func tearDown() {
        remoteMealDataSource = nil
        sut = nil
    }

    func testFetchMealInfo() async throws {
        XCTAssertEqual(remoteMealDataSource.fetchMealInfoCallCount, 0)
        let expected = [MealInfoEntity(meals: ["밥"], mealType: .breakfast)]
        remoteMealDataSource.fetchMealInfoReturn = expected

        let actual = try await sut.fetchMealInfo(date: .init())

        XCTAssertEqual(remoteMealDataSource.fetchMealInfoCallCount, 1)
        XCTAssertEqual(actual, expected)
    }
}
