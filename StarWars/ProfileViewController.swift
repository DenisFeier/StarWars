//
//  ProfileViewController.swift
//  StarWars
//
//  Created by Denis Feier on 14/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit
import SwiftyBeaver

class ProfileViewController: UIViewController {
    @IBOutlet weak var oldPassword: CustomTextField!
    @IBOutlet weak var newPassword: CustomTextField!
    @IBOutlet weak var rePassword: CustomTextField!
    @IBOutlet weak var userDesciption: UITextView!
    
    var logger: SwiftyBeaver.Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = User.getLoginUser() else { return }
        userDesciption.text = user.userDescription
        
        oldPassword.isSecureTextEntry = true
        newPassword.isSecureTextEntry = true
        rePassword.isSecureTextEntry = true
        
        self.logger = SwiftyBeaver.self
    }
    

    @IBAction func pushChangePass(_ sender: Any) {
        guard let user = User.getLoginUser() else { return }
        
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        if oldPassword?.text == user.password {
            if rePassword?.text == newPassword?.text {
                User.changePassword(username: user.username, password: newPassword.text!)
                guard let updated = User.findByName(username: user.username) else { return }
                User.loginSaveUser(username: updated.username)
                let ac = UIAlertController(title: "Password Updatd", message: "Your password has been updated", preferredStyle: .alert)
                ac.addAction(action)
                present(ac, animated: true)
            } else {
                logger.error("New password doesn't match re-password")
                let ac = UIAlertController(title: "Error", message: "New Password doesn't match with Re-Password", preferredStyle: .alert)
                ac.addAction(action)
                present(ac, animated: true)
            }
        } else {
            logger.error("Old Password doesn't match")
            let ac = UIAlertController(title: "Error", message: "Old Password doesn't match", preferredStyle: .alert)
            ac.addAction(action)
            present(ac, animated: true)
        }
    }
    
    @IBAction func updateDescription(_ sender: Any) {
        guard let user = User.getLoginUser() else { return }
        if let text = userDesciption?.text {
            User.updateUserDescription(username: user.username, userDescription: text)
            let ac = UIAlertController(title: "Description Updated", message: "Your description has been updated", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            ac.addAction(action)
            present(ac, animated: true)
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        User.deleteLoginUser()
        self.performSegue(withIdentifier: "logoutButton", sender: nil)
    }
}
