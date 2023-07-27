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

    func test_FetchMusicList_When_Invalid_URL() async throws {
        let musicList = [
            MusicEntity(
                id: 1,
                url: "youtubeURL",
                username: "username",
                createdTime: .init(),
                stuNum: "stuNum"
            )
        ]
        musicRepository.fetchMusicListHandler = { _ in musicList }
        XCTAssertEqual(musicRepository.fetchMusicListCallCount, 0)

//        let actual = try await sut(date: "")

//        XCTAssertEqual(musicRepository.fetchMusicListCallCount, 1)
        #warning("정상적인 Entitiy to Model로 변환된 값 테스트 필요")
    }
}
