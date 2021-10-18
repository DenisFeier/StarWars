//
//  PersonPer+CoreDataProperties.swift
//  
//
//  Created by Denis Feier on 22/07/2020.
//
//

import Foundation
import CoreData


extension PersonPer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonPer> {
        return NSFetchRequest<PersonPer>(entityName: "PersonPer")
    }

    @NSManaged public var name: String?
    @NSManaged public var urlId: Int64
    @NSManaged public var myShip: StarShipPer?

}
