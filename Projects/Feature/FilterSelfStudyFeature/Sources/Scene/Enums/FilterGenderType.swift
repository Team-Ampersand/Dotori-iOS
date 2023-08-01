import Foundation
import Localization

enum FilterGenderType: String, CaseIterable {
    case man = "MAN"
    case woman = "WOMAN"

    init?(index: Int) {
        guard FilterGenderType.allCases.count > index else {
            return nil
        }
        self = FilterGenderType.allCases[index]
    }
}

extension FilterGenderType {
    var display: String {
        switch self {
        case .man: return L10n.FilterSelfStudy.genderMan
        case .woman: return L10n.FilterSelfStudy.genderWoman
        }
    }

    var toIndex: Int {
        switch self {
        case .man: return 0
        case .woman: return 1
        }
    }
}
