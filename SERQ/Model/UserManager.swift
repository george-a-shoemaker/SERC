//
//  UserManager.swift
//  SERQ
//
//  Created by George Shoemaker on 4/27/23.
//

import Foundation

struct UserName {
    let lastName:String
    let firstNameInitial: String
    
    func toArray() -> [String] {
        return [lastName, firstNameInitial]
    }
    
    fileprivate static func from(array: [String]) -> UserName {
        return UserName(lastName: array[0], firstNameInitial: array[1])
    }
}

class UserManager {
    
    static let shared = UserManager()
    
    private let userDefaults = UserDefaults()
    private let USER_KEY = "LastNameFirstNameInitialArray"
    
    private init() {}
    
    func set(userName: UserName) {
        userDefaults.set(userName.toArray(), forKey: USER_KEY)
    }
    
    func getUser() -> UserName? {
        guard let array = userDefaults.stringArray(forKey: USER_KEY) else {
            return nil
        }
        
        return UserName.from(array: array)
    }
}
