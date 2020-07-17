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

    var people: [Person] = []
    var filteredPeople: [Person] = []
    var logger: SwiftyBeaver.Type!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        self.logger = SwiftyBeaver.self
        self.logger.info("Table load")
        super.viewDidLoad()
        searchBar.delegate = self
        
        let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
        
        AF.request("http://swapi.dev/api/people/?page=2").responseJSON(queue: userInteractiveQueue) { [unowned self] response in
            
            let jsondecoder = JSONDecoder()
            self.logger.debug("try to load some data")
            
            guard let responseData = response.data else {
                self.logger.error("Failed to fetch data")
                return
            }
            
            if let jsonData = try? jsondecoder.decode(People.self, from: responseData) {
                self.people = jsonData.results
                
                let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
                
                for (i, guy) in self.people.enumerated() {
                    AF.request(guy.homeworld!).responseJSON(queue: userInteractiveQueue) { [unowned self] response in
                        
                        guard let homeworldData = response.data else {
                            self.logger.error("Failed to decode homeworld data")
                            return
                        }
                        
                        if let jsonData = try? jsondecoder.decode(HomeWorld.self, from: homeworldData) {
                            self.people[i].homeworld = jsonData.name
                        } else {
                            self.logger.error("Failed to parse json data")
                        }
                    }
                }
                
            } else {
                self.logger.error("Failed to decode data")
            }
            
            DispatchQueue.main.async { [unowned self] in
                self.filteredPeople = self.people
                self.tableView.reloadData()
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
            filteredPeople = people
        } else {
            for guy in people {
                if guy.name!.lowercased().contains(searchText.lowercased()) {
                    filteredPeople.append(guy)
                }
            }
        }
        tableView.reloadData()
    }
    
}
