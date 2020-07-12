//
//  ViewController.swift
//  StarWars
//
//  Created by Denis Feier on 09/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.isSecureTextEntry = true
    }

    @IBAction func loginUser(_ sender: Any) {
        guard let name = username.text else { return }
        guard let pass = password.text else { return }
        
        if let user = User.findByName(username: name) {
            if user.password != pass {
                let wrongPass = UIAlertController(
                    title: "Error",
                    message: "Wrong password",
                    preferredStyle: .alert)
                let actionCancel = UIAlertAction(
                    title: "OK",
                    style: .cancel)
                wrongPass.addAction(actionCancel)
                present(wrongPass, animated: true)
            } else {
                print("OK we good")
            }
        } else {
            let acNotFound = UIAlertController(
                title: "Error",
                message: "Username not found",
                preferredStyle: .alert)
            
            let actionCancel = UIAlertAction(
                title: "OK",
                style: .cancel)
            acNotFound.addAction(actionCancel)
            present(acNotFound, animated: true)
        }
    }
}

