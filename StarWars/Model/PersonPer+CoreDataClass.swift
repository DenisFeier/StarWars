//
//  PersonPer+CoreDataClass.swift
//  
//
//  Created by Denis Feier on 22/07/2020.
//
//

import Foundation
import CoreData

@objc(PersonPer)
public class PersonPer: NSManagedObject {
    
    static func checkIfExists(urlId: Int, context: NSManagedObjectContext) -> PersonPer? {
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonPer")
          fetchRequest.predicate = NSPredicate(format: "urlId = %d", urlId)

          var results: [PersonPer] = []

          do {
              results = try context.fetch(fetchRequest) as! [PersonPer]
          }
          catch {
              print("error executing fetch request: \(error)")
          }

          return results.count > 0 ? results[0] : nil
    }
    
}
