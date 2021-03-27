//
//  MovieCoreData+CoreDataProperties.swift
//  Batman
//
//  Created by Henry Chukwu on 27/03/2021.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var director: String?
    @NSManaged public var poster: String?
    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var rated: String?
    @NSManaged public var released: String?
    @NSManaged public var runtime: String?
    @NSManaged public var genre: String?
    @NSManaged public var writer: String?
    @NSManaged public var actors: String?
    @NSManaged public var language: String?
    @NSManaged public var country: String?
    @NSManaged public var awards: String?
    @NSManaged public var imdbID: String?
    @NSManaged public var type: String?

}
