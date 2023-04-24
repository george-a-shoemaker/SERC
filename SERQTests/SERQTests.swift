//
//  SERQTests.swift
//  SERQTests
//
//  Created by George Shoemaker on 4/20/23.
//

import XCTest
@testable import SERQ

final class SERQTests: XCTestCase {

    func testGetWaitlistMen() async throws {
        
        let networkManager = NetworkManager.shared
        do {
            let data = try await networkManager.getWaitlistMen()
            let waitlist = WaitlistItem.parseJsonArray(data: data)
            
            XCTAssertNotNil(waitlist)
            
            XCTAssertEqual(
                waitlist![0],
                WaitlistItem(
                    position: 1,
                    lastName: "Blumberg",
                    firstNameInitial: "M"
                )
            )
        } catch {
            XCTFail("Threw !")
        }
    }
    
    func testGetWaitlistMenSearch() async throws {
        let networkManager = NetworkManager.shared
        do {
            let data = try await networkManager.getWaitlistMenSearch(lastName: "Blumberg", firstNameInitial: "M")
            let item = WaitlistItem.parseJsonItem(data: data)
            
            XCTAssertNotNil(item)
            
            XCTAssertEqual(
                item,
                WaitlistItem(
                    position: 1,
                    lastName: "Blumberg",
                    firstNameInitial: "M"
                )
            )
        } catch {
            XCTFail("Threw !")
        }
    }
}
