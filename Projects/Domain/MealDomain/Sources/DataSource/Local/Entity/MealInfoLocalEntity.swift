import Foundation
import GRDB
import MealDomainInterface

struct MealInfoLocalEntity: Codable, FetchableRecord, PersistableRecord {
    let id: String
    let date: Date
    let meals: [String]
    let mealType: String

    init(id: String = UUID().uuidString, date: Date, meals: [String], mealType: String) {
        self.id = id
        self.date = date
        self.meals = meals
        self.mealType = mealType
    }

    init(date: Date, mealInfoEntity: MealInfoEntity) {
        self.init(
            date: date,
            meals: mealInfoEntity.meals,
            mealType: mealInfoEntity.mealType.rawValue
        )
    }
}

extension MealInfoLocalEntity {
    func toDomainEntity() -> MealInfoEntity {
        MealInfoEntity(
            meals: meals,
            mealType: MealType(rawValue: mealType) ?? .breakfast
        )
    }
}
