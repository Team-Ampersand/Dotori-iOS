import BaseFeature
import Combine

final class SigninStore: BaseStore {
    struct State: Equatable {
    }
    enum Action: Equatable {
    }

    let stateSubject = CurrentValueSubject<State, Never>(State())
    
    func process(_ action: Action) {
        
    }
}
