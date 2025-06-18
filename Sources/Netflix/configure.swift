import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor
// configures your application
public func configure(_ app: Application) async throws {
    app.directory.publicDirectory
    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ??
            "db-mysql-sfo3-61603-do-user-22895153-0.g.db.ondigitalocean.com",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 25060,
        username: Environment.get("DATABASE_USERNAME") ?? "doadmin",
        password: Environment.get("DATABASE_PASSWORD") ?? "AVNS_6J6zXmuRLcpI-XKqsxq",
        database: Environment.get("DATABASE_NAME") ?? "netflix_db",
        tlsConfiguration: .forClient(certificateVerification: .none)
    ), as: .mysql)
 app.migrations.add(CreateSerie())
 app.migrations.add(CreateMovie())
 app.migrations.add(CreateSV())
 // register routes
 try routes(app)
}