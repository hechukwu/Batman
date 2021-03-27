//
//  MovieCoreData+CoreDataClass.swift
//  Batman
//
//  Created by Henry Chukwu on 27/03/2021.
//
//

import Foundation
import CoreData

@objc(MovieCoreData)
public class MovieCoreData: NSManagedObject {

    static let ENTITY_NAME = String(describing: MovieCoreData.self)

    @nonobjc public class func fetchRequestSorted(id: String? = nil) -> NSFetchRequest<MovieCoreData> {
        let request = NSFetchRequest<MovieCoreData>(entityName: ENTITY_NAME)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]

        var predicates: [NSPredicate] = []
        if let id = id {
            predicates.append(NSPredicate(format: "imdbID == %@", id))
        }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return request
    }
}

extension MovieCoreData {
    func toMovieModel() -> Movie {
        let model = Movie(Title: title,
                          Year: year,
                          Rated: rated,
                          Released: released,
                          Runtime: runtime,
                          Genre: genre,
                          Director: director,
                          Writer: writer,
                          Actors: actors,
                          Language: language,
                          Country: country,
                          Awards: awards,
                          Poster: poster,
                          imdbID: imdbID,
                          Type: type)

        return model
    }
}
