import DatabaseInterface
import Foundation
import MealDomainInterface

final class LocalMealDataSourceImpl: LocalMealDataSource {
    private let database: any LocalDatabase

    init(database: any LocalDatabase) {
        self.database = database
    }

    func loadMealInfo(date: Date) throws -> [MealInfoEntity] {
        try database.readRecords(
            as: MealInfoLocalEntity.self,
            filter: ["date": date],
            ordered: []
        )
        .map { $0.toDomainEntity() }
    }

    func saveMealInfoList(date: Date, mealInfoList: [MealInfoEntity]) throws {
        let mealInfoLocalEntityList = mealInfoList
            .map { MealInfoLocalEntity(date: date, mealInfoEntity: $0) }
        try database.save(records: mealInfoLocalEntityList)
    }

    func deleteMealInfoByDate(date: Date) throws {
        try database.delete(as: MealInfoLocalEntity.self, key: date)
    }

    func deleteMealInfoByNotNearToday() throws {
        try database.readRecords(as: MealInfoLocalEntity.self)
            .filter { $0.date.isNearToday() == false }
            .forEach { try database.delete(as: MealInfoLocalEntity.self, key: $0.date) }
    }
}

extension Date {
    func isNearToday() -> Bool {
        let today = Date()
        let yesterday = today.addingTimeInterval(-86400 * 7)
        let tomorrow = today.addingTimeInterval(86400 * 7)
        return yesterday...tomorrow ~= self
    }
}
