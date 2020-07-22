//
//  PeopleTableViewController.swift
//  StarWars
//
//  Created by Denis Feier on 15/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyBeaver

class PeopleTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    var unsafePeople: [Person] = []
    var filteredPeople: [Person] = []
    
    var userInteractiveQueue: DispatchQueue!
    
    var logger: SwiftyBeaver.Type!
    
    var people: [Person] {
        var people: [Person]!
        userInteractiveQueue.sync {
            people = self.unsafePeople
        }
        return people
    }
    
    var selectedPerson: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logger = SwiftyBeaver.self
        searchBar.delegate = self
        
        self.logger.info("Table load")
        
        self.userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
        
        AF.request("http://swapi.dev/api/people/?page=2").responseJSON(queue: userInteractiveQueue) { [unowned self] response in
            
            let jsondecoder = JSONDecoder()
            self.logger.info("try to load some data")
            
            guard let responseData = response.data else {
                self.logger.error("Failed to fetch data")
                return
            }
            
            guard let jsonData = try? jsondecoder.decode(People.self, from: responseData) else {
                self.logger.error("Failed to decode data")
                return
            }
            
            self.unsafePeople = jsonData.results
            
            DispatchQueue.main.async { [unowned self] in
                self.filteredPeople = self.people
                self.tableView.reloadData()
            }
            
            
            for (i, person) in self.people.enumerated() {
                AF.request(person.homeworld!).responseJSON(queue: self.userInteractiveQueue) { [unowned self] response in
                    
                    guard let homeworldData = response.data else {
                        self.logger.error("Failed to decode homeworld data")
                        return
                    }
                    
                    guard let jsonHomeData = try? jsondecoder.decode(HomeWorld.self, from: homeworldData) else {
                        self.logger.error("Failed to parse json data")
                        return
                    }
                    
                    self.userInteractiveQueue.async(flags: .barrier) { [unowned self] in
                        self.unsafePeople[i].homeworld = jsonHomeData.name
                        
                        DispatchQueue.main.async { [unowned self] in
                            self.filteredPeople = self.people
                            let indexPath = IndexPath(item: i, section: 0)
                            
                           
                            
                            guard let contains = self.tableView.indexPathsForVisibleRows?.contains(where: {
                                index in
                                return index.row == indexPath.row && index.section == indexPath.section
                            }) else {
                                return
                            }
                            
                            if contains {
                                self.logger.debug("Update cell at index: \(i)")
                                self.tableView.reloadRows(at: [indexPath], with: .fade)
                            }
                            
                        }
                    }
                    
                }
            }
        
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredPeople.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "People") as! PersonTableViewCell
        cell.setData(person: filteredPeople[indexPath.row])
        return cell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPeople = []
        if searchText == "" {
            filteredPeople = self.people
        } else {
            for guy in unsafePeople {
                if guy.name!.lowercased().contains(searchText.lowercased()) {
                    filteredPeople.append(guy)
                }
            }
        }
        tableView.reloadData()
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPerson = people[indexPath.row]
        performSegue(withIdentifier: "toDetailsScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsScreen" {
            if let destCV = segue.destination as? DetailsScreenViewController {
                destCV.person = self.selectedPerson
            }
        }
    }
    
    
}
