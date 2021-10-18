//
//  Person.swift
//  StarWars
//
//  Created by Denis Feier on 16/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    let name: String?
    let height: String?
    let mass: String?
    let hair_color: String?
    let skin_color: String?
    let eye_color: String?
    let birth_year: String?
    let gender: String?
    
    var homeworld: String?
    
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
    let created: String?
    let edited: String?
    let url: String?
    
    init(name: String, height: String, mass: String, hair_color: String, skin_color: String, eye_color: String, birth_year: String, gender: String, homeworld: String, films: [String], species: [String], vehicles: [String], starships: [String], created: String, edited: String, url: String) {
        self.name = name
        self.height = height
        self.mass = mass
        self.hair_color = hair_color
        self.skin_color = skin_color
        self.eye_color = eye_color
        self.birth_year = birth_year
        self.gender = gender
        self.homeworld = homeworld
        self.films = films
        self.species = species
        self.vehicles = vehicles
        self.starships = starships
        self.created = created
        self.edited = edited
        self.url = url
    }
}
