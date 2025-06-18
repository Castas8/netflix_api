import Fluent
import Vapor
struct SVController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let svRoute = routes.grouped("sv")
        svRoute.get(use: getAll)
        svRoute.post(use: create)
        svRoute.group(":svID") { sv in
        sv.get(use: getAll)
        sv.put(use: update)
        sv.delete(use: delete)
        }
    }
    
    func getAll(req: Request) throws -> EventLoopFuture<[SV]> {
        return SV.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<SV> {
        let sv = try req.content.decode(SV.self)
        return sv.save(on: req.db).map { sv }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return SV.find(req.parameters.get("svID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }
        .transform(to: .ok)
    }

    func update(req: Request) throws -> EventLoopFuture<SV> {
        let updatedSV = try req.content.decode(SV.self)
        return SV.find(req.parameters.get("svID"), on: req.db)
        .unwrap(or: Abort(.notFound))
        .flatMap { sv in
            sv.title = updatedSV.title
            sv.description = updatedSV.description
            sv.rating = updatedSV.rating
            sv.genre = updatedSV.genre
            sv.duration = updatedSV.duration
            sv.image = updatedSV.image
            return sv.save(on: req.db).map { sv }
        }
    }
}