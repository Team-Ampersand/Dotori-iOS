import AsyncNeiSwift
import DateUtility
import Foundation
import MealDomainInterface
import NeiSwift

final class RemoteMealDataSourceImpl: RemoteMealDataSource {
    private let neis: any AsyncNeisProtocol

    init(neis: any AsyncNeisProtocol) {
        self.neis = neis
    }

    func fetchMealInfo(date: Date) async throws -> [MealInfoEntity] {
        let apiKey = Bundle.meal.object(forInfoDictionaryKey: "NEIS_API_KEY") as? String ?? ""
        let request = MealInfoRequest(
            key: apiKey,
            ATPT_OFCDC_SC_CODE: "F10",
            SD_SCHUL_CODE: "7380292",
            MLSV_YMD: date.toStringWithCustomFormat("yyyyMMdd")
        )

        return try await neis.fetchMealInfo(request: request)
            .toEntity()
    }
}

extension [MealInfoResponse] {
    func toEntity() -> [MealInfoEntity] {
        self.map {
            MealInfoEntity(
                meals: $0.DDISH_NM.components(separatedBy: "<br/>"),
                mealType: MealType(rawValue: $0.MMEAL_SC_NM) ?? .breakfast
            )
        }
    }
}
