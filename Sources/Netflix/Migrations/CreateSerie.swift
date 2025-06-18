import Fluent
struct CreateSerie: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
    return database.schema("Series")
    .id()
    .field("title", .string, .required)
    .field("description", .custom("VARCHAR(500)"), .required)
    .field("release", .date, .required)
    .field("rating", .double, .required)
    .field("genre", .string, .required)
    .field("duration", .string, .required)
    .field("image", .custom("VARCHAR(500)"), .required)
    .create()
    }
    func revert(on database: any Database) -> EventLoopFuture<Void> {
    return database.schema("Series").delete()
    }
}