import Fluent
import Vapor

final class Movie: Model, Content, @unchecked Sendable{
    static let schema = "Movie"
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "rating")
    var rating: Double
    
    @Field(key: "release")
    var release: Date
    
    @Field(key: "duration")
    var duration: String
    
    @Field(key: "image")
    var image: String
    
    init () {}
    init(id: UUID? = nil, title: String, description: String, release: Date, rating: Double, duration: String, image: String) {
        self.id = id
        self.title = title
        self.description = description
        self.release = release
        self.rating = rating
        self.duration = duration
        self.image = image
    }
}