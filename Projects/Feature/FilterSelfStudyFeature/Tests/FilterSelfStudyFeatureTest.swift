@testable import FilterSelfStudyFeature
import XCTest

final class FilterSelfStudyFeatureTests: XCTestCase {
    var sut: FilterSelfStudyStore!

    override func setUp() {
        sut = .init { _, _, _, _ in }
    }

    override func tearDown() {
        sut = nil
    }

    func testUpdateName() {
        let name = "name"
        sut.send(.updateName(name))
        XCTAssertEqual(sut.currentState.name, name)
    }

    func testUpdateGrade() {
        let index = 1
        sut.send(.updateGrade(index))
        XCTAssertEqual(sut.currentState.grade, index + 1)
    }

    func testUpdateClass() {
        let index = 1
        sut.send(.updateClass(index))
        XCTAssertEqual(sut.currentState.class, index + 1)
    }

    func testUpdateGender() {
        let index = 1 // woman
        sut.send(.updateGender(index))
        XCTAssertEqual(sut.currentState.gender, .woman)
    }

    func testResetButtonDidTap() {
        let grade = 0
        sut.send(.updateGrade(grade))
        XCTAssertEqual(sut.currentState.grade, grade + 1)
        let `class` = 0
        sut.send(.updateClass(`class`))
        XCTAssertEqual(sut.currentState.class, `class` + 1)

        sut.send(.resetButtonDidTap)
        XCTAssertEqual(sut.currentState.grade, nil)
        XCTAssertEqual(sut.currentState.class, nil)
    }
}
