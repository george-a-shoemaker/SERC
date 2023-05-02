//
//  WaitListManager.swift
//  SERQ
//
//  Created by George Shoemaker on 5/1/23.
//

// TODO: employ this https://swiftbysundell.com/articles/swift-actors/

import Foundation

actor WaitListCache {
    
    static let shared = WaitListCache()
    
//    private var activeTasks = [String: Task<[WaitListItem], Error>]()
    
    private var _waitList: [WaitListItem]? = nil
    
    private init() {}
    
    var hasWaitlist : Bool {
        return _waitList != nil
    }
    
    var waitList : [WaitListItem]? {
        get async {
            if let _waitList { return _waitList }
            return await refresheWaitlist()
        }
    }
    
    func refresheWaitlist() async -> [WaitListItem]? {
        do {
            let data = try await NetworkManager.shared.getWaitlistMen()
            _waitList = WaitListItem.parseJsonArray(data: data)
        } catch {
            _waitList = nil
            print(error)
        }
        return _waitList
    }
}


