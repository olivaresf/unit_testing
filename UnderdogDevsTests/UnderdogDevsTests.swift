//
//  UnderdogDevsTests.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 2/4/21.
//

import XCTest
@testable import UnderdogDevs

class UnderdogDevsTests: XCTestCase {

    // This function does not test anything of value to us.
    func testSuccessfulPlanetFetch() throws {
        
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        networkController.fetchPlanets { result in
            switch result {
            
            case .failure(let error):
                XCTAssert(false)
                
            case .success(let planets):
                // Doesn't cover when planets is empty.
                XCTAssert(true)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            // Checks for errors.
            print("Finished waiting: \(possibleError)")
        }
        
        // Allow us to continue to the end of the function.
    } // The end of the function ✅
    
    func testFailedPlanetFetch() {
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        networkController.fetchPlanets { result in
            switch result {
            
            case .failure(let error):
                XCTAssert(true)
                
            case .success(let planets):
                // Doesn't cover when planets is empty.
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            // Checks for errors.
            print("Finished waiting: \(possibleError)")
        }
        
        // Allow us to continue to the end of the function.
    } // The end of the function ✅
    
    func testTest() {
        // Allows us to define the testing flow.
        // XCTAssert(true)
        
        // XCTAssert(true) means that we get to continue execution.
        // XCTAssert(false) means that the test fails.
        
    } // The end of the function ✅
}
