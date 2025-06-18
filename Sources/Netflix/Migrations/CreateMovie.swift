import Fluent
struct CreateMovie: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
    return database.schema("Movies")
    .id()
    .field("title", .string, .required)
    .field("description", .custom("VARCHAR(500)"), .required)
    .field("rating", .double, .required)
    .field("release", .date, .required)
    .field("duracion", .string, .required)
    .field("image", .custom("VARCHAR(500)"), .required)
    .create()
    }
    func revert(on database: any Database) -> EventLoopFuture<Void> {
    return database.schema("Movies").delete()
    }
}