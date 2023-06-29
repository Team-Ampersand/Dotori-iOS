import Foundation
import GRDB

public protocol LocalDatabase {
    func save(record: some FetchableRecord & PersistableRecord) throws

    func save(records: [some FetchableRecord & PersistableRecord]) throws

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: some DatabaseValueConvertible],
        ordered: [some SQLOrderingTerm]
    ) throws -> [Record]

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: some DatabaseValueConvertible],
        ordered: [some SQLOrderingTerm],
        limit: Int,
        offset: Int?
    ) throws -> [Record]

    func readRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: some DatabaseValueConvertible
    ) throws -> Record?

    func updateRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: some DatabaseValueConvertible,
        transform: (inout Record) -> Void
    ) throws

    func delete(
        as record: some FetchableRecord & PersistableRecord
    ) throws

    func delete<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        key: some DatabaseValueConvertible
    ) throws

    func deleteAll<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type
    ) throws
}

public extension LocalDatabase {
    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: some DatabaseValueConvertible],
        ordered: [some SQLOrderingTerm],
        limit: Int,
        offset: Int?
    ) throws -> [Record] {
        try self.readRecords(
            as: record,
            filter: filter,
            ordered: ordered,
            limit: limit,
            offset: offset
        )
    }

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: [String: some DatabaseValueConvertible],
        ordered: [some SQLOrderingTerm]
    ) throws -> [Record] {
        try self.readRecords(
            as: record,
            filter: filter,
            ordered: ordered
        )
    }
}
