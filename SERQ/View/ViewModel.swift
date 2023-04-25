//
//  ViewModel.swift
//  SERQ
//
//  Created by George Shoemaker on 4/24/23.
//

import Foundation

class ViewModel {
    var isLoading = MainBinder(false)
    var error = MainBinder<String?>(nil)
    var waitList = MainBinder<[WaitlistItem]?>(nil)
    
    func requestWaitlist() {
        guard (!isLoading.value) else { return }
        
        Task {
            isLoading.value = true
            do {
                let data = try await NetworkManager.shared.getWaitlistMen()
                self.waitList.value = WaitlistItem.parseJsonArray(data: data)
            } catch {
                print(error)
            }
            isLoading.value = false
        }
    }
}
