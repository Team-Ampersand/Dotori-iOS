import DatabaseInterface
import Foundation
import GRDB
import MealDomainInterface

final class LocalMealDataSourceImpl: LocalMealDataSource {
    private let database: any LocalDatabase

    init(database: any LocalDatabase) {
        self.database = database
    }

    func loadMealInfo(date: Date) throws -> [MealInfoEntity] {
        guard
            let dateStart = Calendar.current.date(
                bySettingHour: 0,
                minute: 0,
                second: 0,
                of: date
            ),
            let dateEnd = Calendar.current.date(
                bySettingHour: 0,
                minute: 0,
                second: 0,
                of: date.addingTimeInterval(86400)
            )
        else {
            return []
        }
        return try database.readRecords(
            as: MealInfoLocalEntity.self,
            filter: (dateStart...dateEnd).contains(Column("date"))
        )
        .map { $0.toDomain() }
    }

    func saveMealInfoList(date: Date, mealInfoList: [MealInfoEntity]) throws {
        let mealInfoLocalEntityList = mealInfoList
            .map { MealInfoLocalEntity(date: date, mealInfoEntity: $0) }
        try database.save(records: mealInfoLocalEntityList)
    }

    func deleteMealInfoByDate(date: Date) throws {
        guard
            let dateStart = Calendar.current.date(
                bySettingHour: 0,
                minute: 0,
                second: 0,
                of: date
            ),
            let dateEnd = Calendar.current.date(
                bySettingHour: 0,
                minute: 0,
                second: 0,
                of: date.addingTimeInterval(86400)
            )
        else {
            return
        }

        try database.readRecords(
            as: MealInfoLocalEntity.self,
            filter: (dateStart...dateEnd).contains(Column("date"))
        )
        .forEach { try database.delete(as: MealInfoLocalEntity.self, key: $0.id) }
    }

    func deleteMealInfoByNotNearToday() throws {
        try database.readRecords(as: MealInfoLocalEntity.self)
            .filter { $0.date.isNearToday() == false }
            .forEach { try database.delete(as: MealInfoLocalEntity.self, key: $0.id) }
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
