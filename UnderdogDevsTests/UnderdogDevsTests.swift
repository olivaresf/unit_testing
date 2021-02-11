//
//  UnderdogDevsTests.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 2/4/21.
//

import XCTest
@testable import UnderdogDevs

class UnderdogDevsTests: XCTestCase {

    func testSuccessfulPlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        networkController.fetchPlanets { result in
            switch result {
            
            case .failure:
                XCTAssert(false)
                
            case .success(let planets):
                XCTAssert(!planets.isEmpty)
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    } // The end of the function ✅
    
}
