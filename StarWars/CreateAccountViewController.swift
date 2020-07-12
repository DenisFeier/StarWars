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
    @IBOutlet weak var age: UIDatePicker!
    @IBOutlet weak var userDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        age.backgroundColor = .gray
        view.backgroundColor = .black
        password.isSecureTextEntry = true
    }
    
    @IBAction func createAccountPushed(_ sender: Any) {
        guard let name = username.text else { return }
        guard let pass = password.text else { return }
        let date = age.date
        let desc = userDescription.text ?? ""
        print(name, pass, date, desc)
        if User.findByName(username: name) != nil {
            let ac = UIAlertController(title: "Error", message: "User name found", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            present(ac, animated: true)
        }
        var users = User.getAllUsers()
        let user = User(username: name, password: pass, birthDay: date, userDescription: desc)
        users.append(user)
        User.saveUsers(users: users)
        dismiss(animated: true)
    }

}
