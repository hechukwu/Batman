import Foundation
import CoreData

class CoreDataStack: NSObject {

    private(set) var persistentContainer: NSPersistentContainer = AppDelegate.standard.persistentContainer

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError

                #if DEVELOPMENT
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif

                print ("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: Movie

    func getMovieController() -> [MovieCoreData]? {
        let object = try? managedObjectContext.fetch(MovieCoreData.fetchRequest()) as? [MovieCoreData]

        return object

    }

    func upsertMovie(_ movie: Movie, save: Bool) -> MovieCoreData {

        var movieObject: MovieCoreData

        //first check if the content exists
        if let existingContent = managedObjectContext.fetchCaught(MovieCoreData.fetchRequestSorted(id: movie.imdbID)).first {
            movieObject = existingContent
        }
        //create new one
        else {
            movieObject = NSEntityDescription.insertNewObject(forEntityName: MovieCoreData.ENTITY_NAME, into: managedObjectContext) as! MovieCoreData
            movieObject.imdbID = movie.imdbID
        }

        movieObject.imdbID = movie.imdbID
        movieObject.actors = movie.Actors
        movieObject.awards = movie.Awards
        movieObject.country = movie.Country
        movieObject.director = movie.Director
        movieObject.genre = movie.Genre
        movieObject.language = movie.Language
        movieObject.poster = movie.Poster
        movieObject.rated = movie.Rated
        movieObject.released = movie.Released
        movieObject.runtime = movie.Runtime
        movieObject.title = movie.Title
        movieObject.type = movie.Type
        movieObject.writer = movie.Writer
        movieObject.year = movie.Year
        movieObject.isFavourite = true

        if save {
            saveContext()
        }

        return movieObject
    }

    func deleteMovie(_ movie: Movie, save: Bool) {
        if let object = managedObjectContext.fetchCaught(MovieCoreData.fetchRequestSorted(id: movie.imdbID)).first {
            managedObjectContext.delete(object)
        }

        if save {
            saveContext()
        }
    }

    @discardableResult
    func upsertMovie(_ contents: [Movie], save: Bool) -> [MovieCoreData] {

        var upsertedObjects: [MovieCoreData] = []
        contents.forEach{
            let contentCD =
                upsertMovie($0, save: false)
            upsertedObjects.append(contentCD)
        }

        if save {
            saveContext()
        }

        return upsertedObjects
    }
}

extension NSManagedObjectContext {

    func fetchCaught<T>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try fetch(request)
        }
        catch {
            print(error)
            return []
        }
    }

}
