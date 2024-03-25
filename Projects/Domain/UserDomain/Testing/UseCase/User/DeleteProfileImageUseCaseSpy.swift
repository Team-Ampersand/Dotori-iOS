import UIKit
import UserDomainInterface

final class DeleteProfileImageUseCaseSpy: DeleteProfileImageUseCase {
    var deleteProfileImageCallCount = 0
    func callAsFunction() async throws {
        deleteProfileImageCallCount += 1
    }
}
