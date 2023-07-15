import CombineMiniature
import Foundation
import MealDomainInterface

struct FetchMealInfoUseCaseImpl: FetchMealInfoUseCase {
    private let mealRepository: any MealRepository

    init(mealRepository: any MealRepository) {
        self.mealRepository = mealRepository
    }

    func callAsFunction(date: Date) -> CombineMiniature<[MealInfoModel]> {
        mealRepository.fetchMealInfo(date: date)
    }
}
