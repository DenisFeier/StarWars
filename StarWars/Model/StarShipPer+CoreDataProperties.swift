//
//  StarShipPer+CoreDataProperties.swift
//  
//
//  Created by Denis Feier on 22/07/2020.
//
//

import Foundation
import CoreData


extension StarShipPer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StarShipPer> {
        return NSFetchRequest<StarShipPer>(entityName: "StarShipPer")
    }

    @NSManaged public var cargo_capacity: String?
    @NSManaged public var crew: String?
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var starship_class: String?
    @NSManaged public var urlId: Int64
    @NSManaged public var myCrew: NSSet?

}

// MARK: Generated accessors for myCrew
extension StarShipPer {

    @objc(addMyCrewObject:)
    @NSManaged public func addToMyCrew(_ value: PersonPer)

    @objc(removeMyCrewObject:)
    @NSManaged public func removeFromMyCrew(_ value: PersonPer)

    @objc(addMyCrew:)
    @NSManaged public func addToMyCrew(_ values: NSSet)

    @objc(removeMyCrew:)
    @NSManaged public func removeFromMyCrew(_ values: NSSet)

}
