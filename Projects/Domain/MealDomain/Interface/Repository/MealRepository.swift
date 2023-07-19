import CombineMiniature
import Foundation

public protocol MealRepository {
    func fetchMealInfo(date: Date) -> CombineMiniature<[MealInfoEntity]>
}
