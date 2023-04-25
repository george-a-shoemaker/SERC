//
//  Binder.swift
//  SERQ
//
//  Created by George Shoemaker on 4/24/23.
//

import Foundation

//protocol Binder {
//    associatedtype ItemType
//    var value: ItemType { get set }
//    func bind(_ listener: @escaping (ItemType) -> Void)
//}


class MainBinder<T>{
    typealias ItemType = T
    
    // callback to deliver the value
    private var listener: ((ItemType) -> Void)?
    
    var value: ItemType {
        didSet { callListenerOnMain() }
    }
    
    init(_ value: ItemType) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        callListenerOnMain()
    }
    
    
    private func callListenerOnMain() {
        guard let listener else { return }
        let _value = value
        
        DispatchQueue.main.async { listener(_value) }
    }
}

class UtilityBinder<T> {
    
    // callback to deliver the value
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet { callListenerOnMain() }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener = listener
        callListenerOnMain()
    }
    
    
    private func callListenerOnMain() {
        guard let listener else { return }
        let _value = value
        
        DispatchQueue.global(qos: .utility).async {
            listener(_value)
        }
    }
}
