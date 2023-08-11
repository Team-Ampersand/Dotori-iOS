@testable import MusicDomain
import MusicDomainInterface
@testable import MusicDomainTesting
import XCTest

final class MusicRepositoryTests: XCTestCase {
    var remoteMusicDataSource: RemoteMusicDataSourceSpy!
    var sut: MusicRepositoryImpl!

    override func setUp() {
        remoteMusicDataSource = .init()
        sut = .init(remoteMusicDataSource: remoteMusicDataSource)
    }

    override func tearDown() {
        remoteMusicDataSource = nil
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
        remoteMusicDataSource.fetchMusicListHandler = { _ in expected }
        XCTAssertEqual(remoteMusicDataSource.fetchMusicListCallCount, 0)

        let actual = try await sut.fetchMusicList(date: "")

        XCTAssertEqual(actual, expected)
        XCTAssertEqual(remoteMusicDataSource.fetchMusicListCallCount, 1)
    }

    func test_RemoveMusic() async throws {
        XCTAssertEqual(remoteMusicDataSource.removeMusicCallCount, 0)

        try await sut.removeMusic(musicID: 1)

        XCTAssertEqual(remoteMusicDataSource.removeMusicCallCount, 1)
    }

    func test_ProposeMusic() async throws {
        XCTAssertEqual(remoteMusicDataSource.proposeMusicCallCount, 0)

        try await sut.proposeMusic(url: "")

        XCTAssertEqual(remoteMusicDataSource.proposeMusicCallCount, 1)
    }
}
