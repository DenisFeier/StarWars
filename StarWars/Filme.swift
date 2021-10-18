//
//  Filme.swift
//  StarWars
//
//  Created by Denis Feier on 20/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class Filme: NSObject, Codable {
    
    let title: String?
    let release_date: String?
    let opening_crawl: String?
    
    init(title: String?, release_date: String?, opening_crawl: String?) {
       self.title = title
       self.release_date = release_date
       self.opening_crawl = opening_crawl
    }
}
