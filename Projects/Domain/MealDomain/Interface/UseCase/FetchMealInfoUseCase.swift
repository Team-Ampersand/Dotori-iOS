import CombineMiniature
import Foundation

public protocol FetchMealInfoUseCase {
    func callAsFunction(date: Date) -> CombineMiniature<[MealInfoModel]>
}
