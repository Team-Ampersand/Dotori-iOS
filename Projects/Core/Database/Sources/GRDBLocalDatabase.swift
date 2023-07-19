import DatabaseInterface
import Foundation
import GRDB

final class GRDBLocalDatabase: LocalDatabase {
    private let dbQueue: DatabaseQueue
    private let migrator: DatabaseMigrator

    init(migrate: (inout DatabaseMigrator) -> Void) {
        var url = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.msg.dotori")!

        if #available(iOS 16, macOS 13.0, *) {
            url.append(path: "Dotori")
        } else {
            url.appendPathComponent("Dotori")
        }

        try? FileManager.default.createDirectory(
            at: url,
            withIntermediateDirectories: false,
            attributes: [
                FileAttributeKey.protectionKey: URLFileProtection.none
            ]
        )

        if #available(iOS 16.0, macOS 13.0, *) {
            url.append(path: "Dotori.sqlite")
        } else {
            url.appendPathComponent("Dotori.sqlite")
        }

        var dir = ""

        if #available(iOS 16.0, macOS 13.0, *) {
            dir = url.path()
        } else {
            dir = url.path
        }

        if #available(iOS 16.0, macOS 13.0, *) {
            dir.replace("%20", with: " ")
        } else {
            dir = dir.replacingOccurrences(of: "%20", with: " ")
        }

        do {
            self.dbQueue = try DatabaseQueue(path: dir)
        } catch {
            fatalError()
        }

        var migrator = DatabaseMigrator()
        migrate(&migrator)
        self.migrator = migrator
        try? self.migrator.migrate(self.dbQueue)
    }

    func save(record: some FetchableRecord & PersistableRecord) throws {
        try self.dbQueue.write { db in
            try record.save(db)
        }
    }

    func save(records: [some FetchableRecord & PersistableRecord]) throws {
        try self.dbQueue.write { db in
            try records.forEach {
                try $0.save(db)
            }
        }
    }

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        ordered: [any SQLOrderingTerm]
    ) throws -> [Record] {
        try self.dbQueue.read { db in
            try record
                .order(ordered)
                .fetchAll(db)
        }
    }

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: SQLSpecificExpressible,
        ordered: [any SQLOrderingTerm]
    ) throws -> [Record] {
        try self.dbQueue.read { db in
            try record
                .filter(filter)
                .order(ordered)
                .fetchAll(db)
        }
    }

    func readRecords<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        filter: SQLSpecificExpressible,
        ordered: [any SQLOrderingTerm],
        limit: Int,
        offset: Int?
    ) throws -> [Record] {
        try self.dbQueue.read { db in
            try record
                .filter(filter)
                .order(ordered)
                .limit(limit, offset: offset)
                .fetchAll(db)
        }
    }

    func readRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: any DatabaseValueConvertible
    ) throws -> Record? {
        try dbQueue.read { db in
            try record.fetchOne(db, key: key)
        }
    }

    func updateRecord<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        at key: any DatabaseValueConvertible,
        transform: (inout Record) -> Void
    ) throws {
        try dbQueue.write { db in
            if var value = try record.fetchOne(db, key: key) {
                try value.updateChanges(db, modify: transform)
            }
        }
    }

    func delete(
        as record: some FetchableRecord & PersistableRecord
    ) throws {
        try dbQueue.write { db in
            _ = try record.delete(db)
        }
    }

    func delete<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type,
        key: any DatabaseValueConvertible
    ) throws {
        try dbQueue.write { db in
            _ = try record.deleteOne(db, key: key)
        }
    }

    func deleteAll<Record: FetchableRecord & PersistableRecord>(
        as record: Record.Type
    ) throws {
        try dbQueue.write { db in
            _ = try record.deleteAll(db)
        }
    }
}
