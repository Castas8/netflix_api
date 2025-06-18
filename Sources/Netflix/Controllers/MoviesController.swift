import Vapor
struct MoviesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let moviesRoute = routes.grouped("movies")
        moviesRoute.get(use: getAllMovies)
        moviesRoute.post(use: createMovie)
        moviesRoute.group(":movieID") { movie in
            movie.get(use: getAllMovies)
            movie.delete(use: deleteMovie)
            movie.put(use: updateMovie)
        }   
    }
    // Get all movies
    func getAllMovies(req: Request) throws -> EventLoopFuture<[Movie]> {
        return Movie.query(on: req.db).all()
    }

    func createMovie(req: Request) throws -> EventLoopFuture<Movie> {
        let movie = try req.content.decode(Movie.self)
        return movie.save(on: req.db).map { movie }
    }

    func deleteMovie(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Movie.find(req.parameters.get("movieID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .transform(to: .noContent)
    }

    func updateMovie(req: Request) throws -> EventLoopFuture<Movie> {
        let updatedMovie = try req.content.decode(Movie.self)
        return Movie.find(req.parameters.get("movieID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { existingMovie in
            existingMovie.title = updatedMovie.title
            existingMovie.description = updatedMovie.description
            existingMovie.release = updatedMovie.release
            existingMovie.rating = updatedMovie.rating
            existingMovie.duration = updatedMovie.duration
            existingMovie.image = updatedMovie.image
            return existingMovie.save(on: req.db).map { existingMovie }
        }
    }
}