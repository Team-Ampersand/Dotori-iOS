import DatabaseInterface
import Swinject

public final class DatabaseAssembly: Assembly {
    public init() {}
    /// swiftlint : disable identifier_name
    public func assemble(container: Container) {
        container.register(LocalDatabase.self) { _ in
            GRDBLocalDatabase { migrator in
                #if DEBUG
                migrator.eraseDatabaseOnSchemaChange = true
                #endif

                migrator.registerMigration("v1.0.0") { db in
                    try db.create(table: "MealInfoLocalEntity") { table in
                        table.column("id", .text).primaryKey().notNull()
                        table.column("date", .date).notNull()
                        table.column("meals", .text).notNull()
                        table.column("mealType", .text).notNull()
                    }
                }
            }
        }
    }
    // swiftlint : enable identifier_name
}
