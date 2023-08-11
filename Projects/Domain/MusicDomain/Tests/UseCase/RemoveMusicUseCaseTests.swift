@testable import MusicDomain
import MusicDomainInterface
@testable import MusicDomainTesting
import XCTest

final class RemoveMusicUseCaseTests: XCTestCase {
    var musicRepository: MusicRepositorySpy!
    var sut: RemoveMusicUseCaseImpl!

    override func setUp() {
        musicRepository = .init()
        sut = .init(musicRepository: musicRepository)
    }

    override func tearDown() {
        musicRepository = nil
        sut = nil
    }

    func test_RemoveMusic() async throws {
        XCTAssertEqual(musicRepository.removeMusicCallCount, 0)

        try await sut(musicID: 1)

        XCTAssertEqual(musicRepository.removeMusicCallCount, 1)
    }
}
