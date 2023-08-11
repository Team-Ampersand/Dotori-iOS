@testable import KeyValueStore
import XCTest

final class UserDefaultsKeyValueStoreTests: XCTestCase {
    var userDefaults: UserDefaults!
    var keyValueStore: UserDefaultsKeyValueStore!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "testKeyValueUserDefaults")
        keyValueStore = UserDefaultsKeyValueStore(userDefaults: userDefaults)
    }

    override func tearDown() {
        super.tearDown()
        userDefaults.removePersistentDomain(forName: "testKeyValueUserDefaults")
        userDefaults = nil
        keyValueStore = nil
    }

    func testSaveAndLoad() {
        // Given
        let key = "testKey"
        let value = "testValue"

        // When
        keyValueStore.save(key: key, value: value)
        let loadedValue = keyValueStore.load(key: key) as? String

        // Then
        XCTAssertEqual(loadedValue, value, "Loaded value should match the saved value")
    }

    func testLoadWithType() {
        // Given
        let key = "testKey"
        let value = 10

        // When
        keyValueStore.save(key: key, value: value)
        let loadedValue = keyValueStore.load(key: key) as? Int

        // Then
        XCTAssertEqual(loadedValue, value, "Loaded value should match the saved value")
    }

    func testDelete() {
        // Given
        let key = "testKey"
        let value = "testValue"
        keyValueStore.save(key: key, value: value)

        // When
        keyValueStore.delete(key: key)
        let loadedValue = keyValueStore.load(key: key)

        // Then
        XCTAssertNil(loadedValue, "Loaded value should be nil after deletion")
    }
}
