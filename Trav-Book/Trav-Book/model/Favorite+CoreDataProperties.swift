//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Mohamed Zaki on 10/16/20.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var numberOfLike: Int64
    @NSManaged public var numberOfDislike: Int64
    @NSManaged public var user: LoggedUser?

}
