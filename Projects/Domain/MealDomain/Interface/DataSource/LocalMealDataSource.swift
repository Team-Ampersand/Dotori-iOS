import Foundation

public protocol LocalMealDataSource {
    func loadMealInfo(date: Date) throws -> [MealInfoEntity]
    func saveMealInfoList(date: Date, mealInfoList: [MealInfoEntity]) throws
    func deleteMealInfoByDate(date: Date) throws
    func deleteMealInfoByNotNearToday() throws
}
