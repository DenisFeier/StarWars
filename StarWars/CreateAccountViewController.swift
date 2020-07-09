//
//  CreateAccountViewController.swift
//  StarWars
//
//  Created by Denis Feier on 09/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var username: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    @IBOutlet weak var userAge: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        let userName = username.text ?? ""
        let userPass = password.text ?? ""
        let age = userAge.date
        
        let ac = UIAlertController(
            title: "Your Data",
            message: "Username: \(userName),"
                    + "Password: \(userPass),"
                    + "Age: \(age),",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(action)
        
        present(ac, animated: true)
    }
}
