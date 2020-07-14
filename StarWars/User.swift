//
//  User.swift
//  StarWars
//
//  Created by Denis Feier on 10/07/2020.
//  Copyright © 2020 Denis Feier. All rights reserved.
//

import UIKit

class User: NSObject, Codable {

    var username: String
    var password: String
    var birthDay: Date
    var userDescription: String
    
    override var description: String {
        return "User(username = \(username), password = \(password), birthDay = \(birthDay), userDescription = \(userDescription))"
    }
    
    init(username: String, password: String, birthDay: Date, userDescription: String) {
        self.username = username
        self.password = password
        self.birthDay = birthDay
        self.userDescription = userDescription
    }
    
    static func getAllUsers() -> [User] {
        let jsondecoder = JSONDecoder()
        let keychain = KeychainWrapper.standard
        
        if let userData = keychain.data(forKey: "userData") {
           if let persistedUsers = try? jsondecoder.decode([User].self, from: userData) {
                return persistedUsers
           }
        }
        
        return [User]()
    }
    
    static func findByName(username: String) -> User? {
        let users = User.getAllUsers()
        if !users.isEmpty {
            for user in users {
                if user.username == username {
                    return user
                }
            }
        }
        return nil
    }
    
    static func saveUsers(users: [User]) {
        let jsonencoder = JSONEncoder()
        let keychain = KeychainWrapper.standard
        
        if let jsonUser = try? jsonencoder.encode(users) {
            keychain.set(jsonUser, forKey: "userData")
        }
    }
    
    static func loginSaveUser(username: String) {
        let user = User.findByName(username: username)
        let keychain = KeychainWrapper.standard
        let jsonencoder = JSONEncoder()
        if let jsonUser = try? jsonencoder.encode(user) {
            keychain.set(jsonUser, forKey: "loginUser")
        }
    }
    
    static func getLoginUser() -> User? {
        let keychain = KeychainWrapper.standard
        let jsondecoder = JSONDecoder()
        
        if let userData = keychain.data(forKey: "loginUser") {
            if let user = try? jsondecoder.decode(User.self, from: userData) {
                return user
            }
        }
        return nil
    }
    
    static func updateUserDescription(username: String, userDescription: String) {
        var users = User.getAllUsers()
        var index = 0
        for (i, u) in users.enumerated() {
            if u.username == username {
                index = i
                break
            }
        }
        let user = users[index]
        user.userDescription = userDescription
        users[index] = user
        User.saveUsers(users: users)
    }
    
    static func deleteLoginUser() {
        let keychain = KeychainWrapper.standard
        keychain.set(Data(), forKey: "loginUser")
    }
    
    static func changePassword(username: String, password: String) {
        var users = User.getAllUsers()
        var index = 0
        for (i, u) in users.enumerated() {
            if u.username == username {
                index = i
                break
            }
        }
        let user = users[index]
        user.password = password
        users[index] = user
        User.saveUsers(users: users)
    }
}
