//
//  PickUserVM.swift
//  SERQ
//
//  Created by George Shoemaker on 4/24/23.
//

import Foundation

class PickUserVM {
    var isLoading = MainBinder(false)
    var error = MainBinder<String?>(nil)
    var userNameList = MainBinder<[UserName]?>(nil)
    
    func userSelected(at index: Int) {
        print("## \(userNameList.value![index]) selected!!")
        
        guard let user = userNameList.value?[index] else { return }
        
        UserManager.shared.set(
            userName: UserName(lastName: user.lastName, firstNameInitial: user.firstNameInitial)
        )
        
        print("## user set to \(UserManager.shared.getUser()!)")
        
        // nav to next screen
    }
    
    func refreshWaitlist() {
        guard (!isLoading.value) else { return }
        
        Task {
            isLoading.value = true
            
            let waitList = await WaitListCache.shared.refresheWaitlist()
            self.userNameList.value = PickUserVM.formatUserList(waitList: waitList)
            
            isLoading.value = false
        }
    }
    
    func requestWaitlist() {
        guard (!isLoading.value) else { return }
        
        Task {
            guard await !WaitListCache.shared.hasWaitlist else {
                self.userNameList.value = PickUserVM.formatUserList(
                    waitList:  await WaitListCache.shared.waitList
                )
                return
            }
            
            isLoading.value = true
            
            let waitList = await WaitListCache.shared.waitList
            self.userNameList.value = PickUserVM.formatUserList(waitList: waitList)
            
            isLoading.value = false
        }
    }
    
    private static func formatUserList(waitList: [WaitListItem]?) -> [UserName] {
        guard let waitList = waitList else { return [] }
        
        return waitList.map {
            UserName(
                lastName: $0.lastName,
                firstNameInitial: $0.firstNameInitial
            )
        }.sorted {
            let a = $0.lastName + $0.firstNameInitial
            let b = $1.lastName + $1.firstNameInitial
            return a <= b
        }
    }
}
