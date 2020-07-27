//
//  FilmeTableViewController.swift
//  StarWars
//
//  Created by Denis Feier on 20/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import Alamofire

class FilmTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var filmesURLs: [String] = []
    
    var films: [Filme] = []
    
    var myNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let dispatchGroup = DispatchGroup()
        let jsondecoder = JSONDecoder()
        let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
        
        for url in filmesURLs {
            dispatchGroup.enter()
            AF.request(url).responseJSON(queue: userInteractiveQueue) { response in
                
                guard let filmData = response.data else {
                    dispatchGroup.leave()
                    return
                }
                
                if let filmJson = try? jsondecoder.decode(Filme.self, from: filmData) {
                    self.films.append(filmJson)
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmeCell") as! FilmTableViewCell
        let film = films[indexPath.row]
        cell.setData(title: film.title!, releaseDate: film.release_date!)
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let opCV = storyboard?.instantiateViewController(identifier: "opCrawl") as? OpeningCrawlViewController {
            opCV.film = films[indexPath.row]
            myNavigationController.pushViewController(opCV, animated: true)
        }
    }
    
}
