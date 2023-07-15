import Foundation
import MealDomainInterface

struct FetchMealInfoUseCaseImpl: FetchMealInfoUseCase {
    private let mealRepository: any MealRepository

    init(mealRepository: any MealRepository) {
        self.mealRepository = mealRepository
    }

    func callAsFunction(date: Date) async throws -> [MealInfoModel] {
        try await mealRepository.fetchMealInfo(date: date)
    }
}
