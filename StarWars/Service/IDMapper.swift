//
//  IDMapper.swift
//  StarWars
//
//  Created by Denis Feier on 22/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class IDMapper {
    
    static func getIdFromURL(url: String) -> Int {
        let fragments = url.components(separatedBy: "/")
        let urlID = fragments[fragments.count - 2]
        return Int(urlID)!
    }
}
