import MusicDomainInterface
import XCTest
@testable import MusicDomain
@testable import MusicDomainTesting

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
}
