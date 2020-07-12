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
        print(users.count)
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
        // let keychain = UserDefaults.standard
        let keychain = KeychainWrapper.standard
        
        if let jsonUser = try? jsonencoder.encode(users) {
            print(users.count)
            keychain.set(jsonUser, forKey: "userData")
        }
    }
}
