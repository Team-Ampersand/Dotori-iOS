import Combine
@testable import MealDomain
import MealDomainInterface
@testable import MealDomainTesting
import Miniature
import XCTest

final class MealRepositoryTests: XCTestCase {
    var remoteMealDataSource: RemoteMealDataSourceSpy!
    var localMealDataSource: LocalMealDataSourceSpy!
    var sut: MealRepositoryImpl!
    var subscription: Set<AnyCancellable>!

    override func setUp() {
        remoteMealDataSource = .init()
        localMealDataSource = .init()
        sut = .init(
            remoteMealDataSource: remoteMealDataSource,
            localMealDataSource: localMealDataSource
        )
        subscription = []
    }

    override func tearDown() {
        remoteMealDataSource = nil
        localMealDataSource = nil
        sut = nil
        subscription = nil
    }

    func testFetchMealInfo() async throws {
        XCTAssertEqual(remoteMealDataSource.fetchMealInfoCallCount, 0)
        XCTAssertEqual(localMealDataSource.loadMealInfoCallCount, 0)
        XCTAssertEqual(localMealDataSource.saveMealInfoListCallCount, 0)
        XCTAssertEqual(localMealDataSource.deleteMealInfoByNotNearTodayCallCount, 0)
        let remoteExpected = [MealInfoEntity(meals: ["밥"], mealType: .breakfast)]
        remoteMealDataSource.fetchMealInfoReturn = remoteExpected

        let localExpected = [MealInfoEntity(meals: ["어제밥"], mealType: .lunch)]
        localMealDataSource.loadMealInfoReturn = localExpected

        let fetchMealInfoMiniature = sut.fetchMealInfo(date: .init())

        var publishCount = 0
        for try await status in fetchMealInfoMiniature.toAnyPublisher().values {
            switch status {
            case let .loading(local):
                XCTAssertEqual(local, localExpected)
                XCTAssertEqual(publishCount, 0)
                publishCount += 1

            case let .completed(remote):
                XCTAssertEqual(remote, remoteExpected)
                XCTAssertEqual(publishCount, 1)
                publishCount += 1

            default:
                XCTFail("Unexpected enum")
            }
        }

        XCTAssertEqual(remoteMealDataSource.fetchMealInfoCallCount, 1)
        XCTAssertEqual(localMealDataSource.loadMealInfoCallCount, 1)
        XCTAssertEqual(localMealDataSource.saveMealInfoListCallCount, 1)
        XCTAssertEqual(localMealDataSource.deleteMealInfoByNotNearTodayCallCount, 1)
    }
}
