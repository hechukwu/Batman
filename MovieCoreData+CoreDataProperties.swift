//
//  MovieCoreData+CoreDataProperties.swift
//  Batman
//
//  Created by Henry Chukwu on 25/03/2021.
//
//

import Foundation
import CoreData


extension MovieCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCoreData> {
        return NSFetchRequest<MovieCoreData>(entityName: "MovieCoreData")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var director: String?
    @NSManaged public var poster: String?
    @NSManaged public var isFavourite: Bool

}
