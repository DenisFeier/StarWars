//
//  OpeningCrawlViewController.swift
//  StarWars
//
//  Created by Denis Feier on 21/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class OpeningCrawlViewController: UIViewController {
    
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var openingCrawl: UITextView!
    
    var film: Filme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleL.text = film.title
        openingCrawl.text = film.opening_crawl
        openingCrawl.isEditable = false
    }
    
}
