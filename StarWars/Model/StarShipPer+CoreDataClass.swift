//
//  StarShipPer+CoreDataClass.swift
//  
//
//  Created by Denis Feier on 22/07/2020.
//
//

import Foundation
import CoreData

@objc(StarShipPer)
public class StarShipPer: NSManagedObject {

    static func checkIfExists(urlId: Int, context: NSManagedObjectContext) -> StarShipPer? {
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StarShipPer")
           fetchRequest.predicate = NSPredicate(format: "urlId = %d", urlId)

           var results: [StarShipPer] = []

           do {
               results = try context.fetch(fetchRequest) as! [StarShipPer]
           }
           catch {
               print("error executing fetch request: \(error)")
           }

           return results.count > 0 ? results[0] : nil
       }
       
       static func toEntityStarShip(ship: StarShipPer) -> StarShip {
           return StarShip(
               name: ship.name,
               model: ship.model,
               starship_class:ship.starship_class,
               cargo_capacity: ship.cargo_capacity,
               crew: ship.crew
           )
       }
       
}
