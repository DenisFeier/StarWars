//
//  StarShipsDetailsScreenViewController.swift
//  StarWars
//
//  Created by Denis Feier on 22/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import SwiftyBeaver
import CoreData

class StarShipsDetailsScreenViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var crew: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var cargoCapacity: UILabel!
    @IBOutlet weak var starshipClass: UILabel!
    @IBOutlet weak var containerDetails: ContainerDetailsView!
    @IBOutlet weak var coolBtn: CoolButton!
    
    var logger: SwiftyBeaver.Type!
    
    var ship: StarShipPer!
    var person: Person!
    
    var context: NSManagedObjectContext!
    
    var reloadTable: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logger = SwiftyBeaver.self
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        name.text = ship.name
        crew.text = ship.crew
        model.text = ship.model
        cargoCapacity.text = ship.cargo_capacity
        starshipClass.text = ship.starship_class
        // Do any additional setup after loading the view.
    }

    @IBAction func tapCustomButton(_ sender: CoolButton) {
        sender.pulsate()
        
        let pulse = PulseAnimation(numberOfPulse: 1, radius: 100, postion: sender.center)
        pulse.animationDuration = 1.0
        let color = UIColor.red.cgColor
        pulse.backgroundColor = color
        self.view.layer.insertSublayer(pulse, below: self.view.layer)
        self.view.bringSubviewToFront(coolBtn)
        
        let urlId = IDMapper.getIdFromURL(url: person.url!)
        guard let personeCoreData = PersonPer.checkIfExists(urlId: urlId, context: self.context) else { return }
        logger.info("Person name: \(String(describing: personeCoreData.name))")
        logger.info("Ship name: \(String(describing: ship.name))")
        
        if let linkWith = personeCoreData.myShip {
            linkWith.removeFromMyCrew(personeCoreData)
            ship.addToMyCrew(personeCoreData)
        } else {
            ship.addToMyCrew(personeCoreData)
        }
        do {
            try self.context.save()
            reloadTable()
        } catch {
            logger.error("Can't add \(String(describing: personeCoreData.name)) to \(String(describing: ship.name))")
        }
        
    }
}
