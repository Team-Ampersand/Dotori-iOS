@testable import MusicDomain
import MusicDomainInterface
@testable import MusicDomainTesting
import XCTest

final class ProposeMusicUseCaseTests: XCTestCase {
    var musicRepository: MusicRepositorySpy!
    var sut: ProposeMusicUseCaseImpl!

    override func setUp() {
        musicRepository = .init()
        sut = .init(musicRepository: musicRepository)
    }

    override func tearDown() {
        musicRepository = nil
        sut = nil
    }

    func test_ProposeMusic() async throws {
        XCTAssertEqual(musicRepository.proposeMusicCallCount, 0)

        try await sut(url: "")

        XCTAssertEqual(musicRepository.proposeMusicCallCount, 1)
    }
}
