//
//  DataModels.swift
//  SERQ
//
//  Created by George Shoemaker on 4/20/23.
//

import Foundation

struct WaitlistItem {
    let position: Int
    let lastName: String
    let firstNameInitial: String
    
    var displayString: String {
        return "\(position): \(firstNameInitial). \(lastName)"
    }
}
