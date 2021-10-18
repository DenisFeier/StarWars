//
//  ViewController.swift
//  StarWars
//
//  Created by Denis Feier on 09/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import SwiftyBeaver

class LoginViewController: UIViewController {
    @IBOutlet weak var username: CustomTextField!
    @IBOutlet weak var password: CustomTextField!
    
    var logger: SwiftyBeaver.Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        password.isSecureTextEntry = true
        self.logger = SwiftyBeaver.self
    }

    override func viewDidAppear(_ animated: Bool) {
        if let user = User.getLoginUser() {
            logger.info("Auto login user with name: \(user.username)")
            self.performSegue(withIdentifier: "LoginSucces", sender: user)
        } else {
            logger.info("No user to auto login")
        }
    }
    
    @IBAction func loginUser(_ sender: Any) {
        guard let name = username.text else { return }
        guard let pass = password.text else { return }
        
        logger.info("User Login")
        
        let actionCancel = UIAlertAction(
            title: "OK",
            style: .cancel)
        
        
        if let user = User.findByName(username: name) {
            if user.password != pass {
                
                let wrongPass = UIAlertController(
                    title: "Error",
                    message: "Wrong password",
                    preferredStyle: .alert)
                
                wrongPass.addAction(actionCancel)
                logger.error("Wrong password")
                present(wrongPass, animated: true)
            } else {
                logger.info("Login succes")
                User.loginSaveUser(username: user.username)
                self.performSegue(withIdentifier: "LoginSucces", sender: user)
            }
        } else {
            let acNotFound = UIAlertController(
                title: "Error",
                message: "Username not found",
                preferredStyle: .alert)
            
            acNotFound.addAction(actionCancel)
            logger.error("User not found")
            present(acNotFound, animated: true)
        }
    }
    
}

