//
//  UnderdogDevsTests.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 2/6/21.
//

import XCTest
@testable import UnderdogDevs

class UnderdogDevsTests: XCTestCase {

    override func setUpWithError() throws {
        // Needed to setup core data
        // In memory store.
        
        // 1. Create a core data instance.
        // 2. Add any initial data as needed.
    }
    
    func testDeleteEverything() {

        // Accessed the core data instance
        // Deletes everything
        // XCTAssert(noRecordsLeft)
    }
    
    override class func tearDown() {
        // 1. Recreate the core data instance.
        // 2. Re-add any initial data.
    }
    
    // False positive
    // A useless test. This isn't testing anything.
    func testFetchPlanetsSuccess() throws {
        
        let networkController = NetworkController()
        networkController.fetchPlanets { result in
            switch result {
            
            case .failure:
                XCTAssert(false)
                
            case .success(let planets):
                // The test will only continue if planets is not empty.
                XCTAssert(!planets.isEmpty)
            }
        }
    }
    
    // Badly designed test before we included the expectation.
    func testFetchPlanetsFailure() {
        
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        networkController.fetchPlanets
        { result in
            switch result {
            
            case .failure:
                // A failure is expected because we're testing the failed state.
                XCTAssert(true)
                
            case .success:
                // A success will fail the test.
                XCTAssert(false)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (possibleError) in
            
        }
        
    } // Test passes ✅
    
}
