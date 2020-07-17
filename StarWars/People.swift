//
//  People.swift
//  StarWars
//
//  Created by Denis Feier on 16/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class People: NSObject, Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Person]
    
    init(count: Int, next: String, previous: String, results: [Person]) {
       self.count = count
       self.next = next
       self.previous = previous
       self.results = results
    }
}
