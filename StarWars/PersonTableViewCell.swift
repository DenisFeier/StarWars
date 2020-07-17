//
//  PersonCellTableViewCell.swift
//  StarWars
//
//  Created by Denis Feier on 16/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyBeaver

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var homeWorld: UILabel!
    @IBOutlet weak var skinColor: UILabel!

    var logger: SwiftyBeaver.Type!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.logger = SwiftyBeaver.self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(person: Person) {
        self.name.text = person.name
        self.gender.text = person.gender
        self.height.text = person.height
        self.hairColor.text = person.hair_color
        self.skinColor.text = person.skin_color
        self.homeWorld.text = person.homeworld
    }

}
