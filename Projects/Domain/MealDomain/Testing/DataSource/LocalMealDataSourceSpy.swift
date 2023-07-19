import Foundation
import MealDomainInterface

final class LocalMealDataSourceSpy: LocalMealDataSource {
    var loadMealInfoCallCount = 0
    var loadMealInfoReturn: [MealInfoEntity] = []
    func loadMealInfo(date: Date) throws -> [MealInfoEntity] {
        loadMealInfoCallCount += 1
        return loadMealInfoReturn
    }

    var saveMealInfoListCallCount = 0
    func saveMealInfoList(date: Date, mealInfoList: [MealInfoEntity]) throws {
        saveMealInfoListCallCount += 1
    }

    var deleteMealInfoByNotNearTodayCallCount = 0
    func deleteMealInfoByNotNearToday() throws {
        deleteMealInfoByNotNearTodayCallCount += 1
    }

    var deleteMealInfoByDateCallCount = 0
    func deleteMealInfoByDate(date: Date) throws {
        deleteMealInfoByDateCallCount += 1
    }
}
