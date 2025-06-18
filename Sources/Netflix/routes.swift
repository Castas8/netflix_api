import Fluent
import Vapor


func routes(_ app: Application) throws {
   app.get { req async in
       "It works!"
   }


   // Puedes dejar estos si quieres accesos directos para GET
   app.get("Series") { req -> EventLoopFuture<[Series]> in
       return Series.query(on: req.db).all()
   }


   app.get("Movies") { req -> EventLoopFuture<[Movie]> in
       return Movie.query(on: req.db).all()
   }


   app.get("SV") { req -> EventLoopFuture<[SV]> in
       return SV.query(on: req.db).all()
   }


   // 👇 Esto es lo que te activa las rutas REST completas
   try  app.register(collection: MoviesController())
   try  app.register(collection: SeriesController())
   try  app.register(collection: SVController())
}