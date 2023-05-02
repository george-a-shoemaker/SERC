//
//  PickUserVM.swift
//  SERQ
//
//  Created by George Shoemaker on 5/1/23.
//

import Foundation

class PositionVM {
    let userManager = UserManager.shared
    
    let user: UserName? = UserManager.shared.getUser()
    var userPosition: Int {
        get async {
            guard
                let user,
                let waitList = await WaitListCache.shared.waitList
            else { return -1 }
            for item in waitList {
                if item.firstNameInitial == user.firstNameInitial && item.lastName == user.lastName {
                    return item.position ?? -2
                }
            }
            return -3
        }
    }
}
