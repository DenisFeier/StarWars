//
//  ShipTableViewCell.swift
//  StarWars
//
//  Created by Denis Feier on 20/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class ShipTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = .darkGray
        self.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(name: String, model: String) {
        self.model.text = model
        self.name.text = name
    }
}
