import UIKit
import UserDomainInterface

final class AddProfileImageUseCaseSpy: AddProfileImageUseCase {
    var addProfileImageCallCount = 0
    func callAsFunction(profileImage: Data) async throws {
        addProfileImageCallCount += 1
    }
}
