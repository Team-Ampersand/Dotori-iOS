import UIKit
import UserDomainInterface

final class AddProfileImageUseCaseSpy: AddProfileImageUseCase {
    func callAsFunction(profileImage: Data) async throws {}
}
