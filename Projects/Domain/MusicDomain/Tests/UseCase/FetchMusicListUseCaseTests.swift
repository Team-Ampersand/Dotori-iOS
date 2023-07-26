import MusicDomainInterface
import XCTest
@testable import MusicDomain
@testable import MusicDomainTesting

final class FetchMusicListUseCaseTests: XCTestCase {
    var musicRepository: MusicRepositorySpy!
    var sut: FetchMusicListUseCaseImpl!

    override func setUp() {
        musicRepository = .init()
        sut = .init(musicRepository: musicRepository)
    }

    override func tearDown() {
        musicRepository = nil
        sut = nil
    }

    func test_FetchMusicList() async throws {
        let expected = [
            MusicEntity(
                id: 1,
                url: "https://www.youtube.com",
                username: "username",
                createdTime: .init(),
                stuNum: "stuNum"
            )
        ]
        musicRepository.fetchMusicListHandler = { expected }
        XCTAssertEqual(musicRepository.fetchMusicListCallCount, 0)

        let actual = try await sut()

        XCTAssertEqual(actual, expected)
        XCTAssertEqual(musicRepository.fetchMusicListCallCount, 1)
    }
}
