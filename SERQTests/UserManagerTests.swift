//
//  UserManagerTests.swift
//  SERQTests
//
//  Created by George Shoemaker on 4/27/23.
//

import XCTest
@testable import SERQ

final class UserManagerTests: XCTestCase {
    
    private let userName = UserName(lastName: "Adams", firstNameInitial: "J")
    private var userNameArray: [String] {
        return [userName.lastName, userName.firstNameInitial]
    }
    
    func testSetUser() {
        UserManager.shared.clearUser()
        XCTAssertFalse(UserManager.shared.hasUser())
    
        UserManager.shared.set(userName: userName)
        XCTAssertTrue(UserManager.shared.hasUser())
        XCTAssertNotNil(UserManager.shared.getUser())
        XCTAssertEqual(UserManager.shared.getUser()!, userName)
    }
}
