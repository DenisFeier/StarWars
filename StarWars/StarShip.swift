//
//  StarShip.swift
//  StarWars
//
//  Created by Denis Feier on 20/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class StarShip: NSObject, Codable {
   
    let name: String?
    let model: String?
    let starship_class: String?
    let cargo_capacity: String?
    let crew: String?
   
    init(name: String?, model: String?, starship_class: String?, cargo_capacity: String?, crew: String?) {
       self.name = name
       self.model = model
       self.starship_class = starship_class
       self.cargo_capacity = cargo_capacity
       self.crew = crew
    }
    
}
