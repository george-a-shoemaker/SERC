//
//  DataModels.swift
//  SERQ
//
//  Created by George Shoemaker on 4/20/23.
//

import Foundation

struct WaitlistItem: Codable, Equatable {
    let position: Int?
    let lastName: String
    let firstNameInitial: String
    
    var displayString: String {
        let positionString: String = position?.description ?? "nil"
        return "\(positionString): \(firstNameInitial). \(lastName)"
    }
    
    static func parseJsonItem(data: Data) -> WaitlistItem? {
        do {
            let decoder = JSONDecoder()
            let item = try decoder.decode(WaitlistItem.self, from: data)
            return item
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func parseJsonArray(data: Data) -> [WaitlistItem]? {
        do {
            let decoder = JSONDecoder()
            let array = try decoder.decode([WaitlistItem].self, from: data)
            return array
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
