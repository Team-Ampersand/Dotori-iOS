import MealDomainInterface
import XCTest
@testable import MealDomainTesting
@testable import MealDomain

final class MealRepositoryTests: XCTestCase {
    var remoteMealDataSourceSpy: RemoteMealDataSourceSpy!
    var sut: MealRepositoryImpl!

    override func setUp() {
        remoteMealDataSourceSpy = .init()
        sut = .init(remoteMealDataSource: remoteMealDataSourceSpy)
    }

    override func tearDown() {
        remoteMealDataSourceSpy = nil
        sut = nil
    }

    func testFetchMealInfo() async throws {
        let expected = [MealInfoEntity(meals: ["밥"], mealType: .breakfast)]
        remoteMealDataSourceSpy.fetchMealInfoReturn = expected

        let actual = try await sut.fetchMealInfo(date: .init())

        XCTAssertEqual(actual, expected)
    }
}
