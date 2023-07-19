import DatabaseInterface
import GRDB

final class LocalDatabaseMock: LocalDatabase {
    var saveCallCount = 0
    func save(record: some FetchableRecord & PersistableRecord) throws {
        saveCallCount += 1
    }

    var allSaveCallCount = 0
    func save(records: [some FetchableRecord & PersistableRecord]) throws {
        allSaveCallCount += 1
    }

    var readRecordsCallCount = 0
    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: any DatabaseValueConvertible],
        ordered: [any SQLOrderingTerm]
    ) throws -> [Record] {
        readRecordsCallCount += 1
        return []
    }

    var readRecordsWithLimitCallCount = 0
    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: any DatabaseValueConvertible],
        ordered: [any SQLOrderingTerm],
        limit: Int,
        offset: Int?
    ) throws -> [Record] {
        readRecordsWithLimitCallCount += 1
        return []
    }

    var readRecordCallCount = 0
    func readRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: any DatabaseValueConvertible
    ) throws -> Record? {
        readRecordCallCount += 1
        return nil
    }

    var updateRecordCallCount = 0
    func updateRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: any DatabaseValueConvertible,
        transform: (inout Record) -> Void
    ) throws {
        updateRecordCallCount += 1
    }

    var deleteCallCount = 0
    func delete(
        as record: some FetchableRecord & PersistableRecord
    ) throws {
        deleteCallCount += 1
    }

    var deleteKeyCallCount = 0
    func delete<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        key: any DatabaseValueConvertible
    ) throws {
        deleteKeyCallCount += 1
    }

    var deleteAllCallCount = 0
    func deleteAll<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type
    ) throws {
        deleteAllCallCount += 1
    }
}
