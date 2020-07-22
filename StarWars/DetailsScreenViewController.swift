//
//  DetailsScreenViewController.swift
//  StarWars
//
//  Created by Denis Feier on 18/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import SwiftyBeaver
import CoreData

class DetailsScreenViewController: UIViewController {
    var person: Person!
    
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var filmesTableViewContainer: UIView!
    @IBOutlet weak var starShipsTableViewContainer: UIView!
    
    var logger: SwiftyBeaver.Type!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(filmesTableViewContainer)
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let urlId = IDMapper.getIdFromURL(url: person.url!)
        
        if PersonPer.checkIfExists(urlId: urlId, context: self.context) == nil {
            let personCoreData = PersonPer(context: self.context)
            personCoreData.name = person.name
            personCoreData.urlId = Int64(urlId)
            do {
                try self.context.save()
            } catch {
                logger.error("Can't save new person with name: \(String(describing: person.name))")
            }
        }
        
        title = person.name
        self.height.text = person.height
        self.mass.text = person.mass
        self.hairColor.text = person.hair_color
        self.skinColor.text = person.skin_color
        self.eyeColor.text = person.eye_color
        self.birthYear.text = person.birth_year
        self.gender.text = person.gender
        
        self.logger = SwiftyBeaver.self
        
    }
    
    @IBAction func switchTableViews(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                view.bringSubviewToFront(filmesTableViewContainer)
            case 1:
                view.bringSubviewToFront(starShipsTableViewContainer)
            default:
                logger.error("No container to be pushed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toFilmesTable" {
            if let filmesTableVC = segue.destination as? FilmeTableViewController {
                filmesTableVC.filmesURLs = person.films
                filmesTableVC.myNavigationController = navigationController
            }
        } else if segue.identifier == "toStarShipesTable" {
            if let starShipTableVC = segue.destination as? StarShipTableViewController {
                starShipTableVC.starShipsURLs = person.starships
                starShipTableVC.person = person
                starShipTableVC.myNavigationController = navigationController
            }
        } else {
            logger.error("segue error, identifier not found")
        }
    }
    
    
}
