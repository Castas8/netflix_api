import Fluent
import Vapor
final class SV: Model, Content, @unchecked Sendable{
    static let schema = "SV"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "rating")
    var rating: Double

    @Field(key: "genre")
    var genre: String

    @Field(key: "duration")
    var duration: String

    @Field(key: "image")
    var image: String

    init () {}
    init(id: UUID? = nil, title: String, description: String, rating: Double, genre: String, duration: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.rating = rating
        self.genre = genre
        self.duration = duration
        self.image = image
    }
}