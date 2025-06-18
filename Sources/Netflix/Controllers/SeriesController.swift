import Fluent
import Vapor
struct SeriesController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let series = routes.grouped("series")
        series.get(use: get)
        series.post(use: create)
        series.group(":seriesID") { series in
        series.get(use: get)
        series.put(use: update)
        series.delete(use: delete)
        }
    }

    /// Get all series
    func get(req: Request) throws -> EventLoopFuture<[Series]> {
        return Series.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Series> {
        let series = try req.content.decode(Series.self)
        return series.save(on: req.db).map { series }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Series.find(req.parameters.get("seriesID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .transform(to: .ok)
    }

    func update(req: Request) throws -> EventLoopFuture<Series> {
        let updatedSeries = try req.content.decode(Series.self)
        return Series.find(req.parameters.get("seriesID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { series in
            series.title = updatedSeries.title
            series.description = updatedSeries.description
            series.release = updatedSeries.release
            series.rating = updatedSeries.rating
            series.genre = updatedSeries.genre
            series.duration = updatedSeries.duration
            series.image = updatedSeries.image
            return series.save(on: req.db).map { series }
        }
    }
}