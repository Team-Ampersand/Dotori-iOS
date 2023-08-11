import MusicDomainInterface
@testable import MusicDomainTesting
@testable import ProposeMusicFeature
import XCTest

final class ProposeMusicFeatureTests: XCTestCase {
    private var proposeMusicUseCase: ProposeMusicUseCaseSpy!
    private var sut: ProposeMusicStore!

    override func setUp() {
        proposeMusicUseCase = .init()
        sut = .init(proposeMusicUseCase: proposeMusicUseCase)
    }

    override func tearDown() {
        proposeMusicUseCase = nil
        sut = nil
    }

    func test_URLState_When_InputURL() {
        let url1 = "https://"
        sut.send(.updateURL(url1))

        XCTAssertEqual(url1, sut.currentState.url)

        let url2 = "https://youtube.com"
        sut.send(.updateURL(url2))

        XCTAssertEqual(url2, sut.currentState.url)
    }
}
