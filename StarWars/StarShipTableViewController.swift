//
//  StarShipTableViewController.swift
//  StarWars
//
//  Created by Denis Feier on 20/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SwiftyBeaver

class StarShipTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var starShipsURLs: [String] = []
    
    var ships: [StarShipPer] = []
    
    var logger: SwiftyBeaver.Type!
    
    var context: NSManagedObjectContext!
    
    var myNavigationController: UINavigationController!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logger = SwiftyBeaver.self
        
        self.tableView.backgroundColor = .black
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let dispatchGroup = DispatchGroup()
        let jsondecoder = JSONDecoder()
        let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
             
        for url in starShipsURLs {
            dispatchGroup.enter()
            
            let urlId = IDMapper.getIdFromURL(url: url)
            
            let ship = StarShipPer.checkIfExists(urlId: urlId, context: self.context)
            
            if ship == nil {
                
                AF.request(url).responseJSON(queue: userInteractiveQueue) { response in
                     
                    guard let starShipData = response.data else {
                        dispatchGroup.leave()
                        return
                    }
                     
                    if let starShipJson = try? jsondecoder.decode(StarShip.self, from: starShipData) {
                       
                        let newShip = StarShipPer(context: self.context)
                        
                        newShip.cargo_capacity = starShipJson.cargo_capacity
                        newShip.crew = starShipJson.crew
                        newShip.model = starShipJson.model
                        newShip.name = starShipJson.name
                        newShip.urlId = Int64(urlId)
                        newShip.starship_class = starShipJson.starship_class
                        
                        do {
                            try self.context.save()
                            self.logger.warning("Ship with id: \(urlId) from API")
                            self.ships.append(newShip)
                        } catch {
                            self.logger.error("Can't create new ship Entity from json")
                        }
                        dispatchGroup.leave()
                    }
                }
            
            } else {
                logger.warning("Ship with id: \(urlId) from coreData")
                dispatchGroup.leave()
                guard let myShip = ship else { return }
                ships.append(myShip)
            }
            
        }
         
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return ships.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let urlId = IDMapper.getIdFromURL(url: person.url!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "shipCell") as! ShipTableViewCell
        let ship = ships[indexPath.section]
        
        if let personCoreData = PersonPer.checkIfExists(urlId: urlId, context: self.context) {
            if let currentShip = personCoreData.myShip {
                if currentShip.urlId == ship.urlId {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
        }
        cell.setData(name: ship.name!, model: ship.model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let view = storyboard?.instantiateViewController(identifier: "shipDetailView") as? StarShipsDetailsScreenViewController {
            view.ship = ships[indexPath.section]
            view.person = person
            view.reloadTable = forTableReload
            myNavigationController?.pushViewController(view, animated: true)
        }
    }
    
    func forTableReload() {
        self.tableView.reloadData()
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5
        return cellSpacingHeight
    }
          
          // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

}
