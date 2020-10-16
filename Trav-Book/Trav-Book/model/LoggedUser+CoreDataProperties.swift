//
//  LoggedUser+CoreDataProperties.swift
//  
//
//  Created by Mohamed Zaki on 10/16/20.
//
//

import Foundation
import CoreData


extension LoggedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoggedUser> {
        return NSFetchRequest<LoggedUser>(entityName: "LoggedUser")
    }

    @NSManaged public var age: Int64
    @NSManaged public var name: String?
    @NSManaged public var postss: [String]?
    @NSManaged public var favorite: NSSet?

}

// MARK: Generated accessors for favorite
extension LoggedUser {

    @objc(addFavoriteObject:)
    @NSManaged public func addToFavorite(_ value: Favorite)

    @objc(removeFavoriteObject:)
    @NSManaged public func removeFromFavorite(_ value: Favorite)

    @objc(addFavorite:)
    @NSManaged public func addToFavorite(_ values: NSSet)

    @objc(removeFavorite:)
    @NSManaged public func removeFromFavorite(_ values: NSSet)

}
