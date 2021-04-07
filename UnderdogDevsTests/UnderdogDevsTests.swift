//
//  UnderdogDevsTests.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 4/6/21.
//

import XCTest
@testable import UnderdogDevs

class UnderdogDevsTests: XCTestCase {

    func testFetchPlanetsSuccess() {
        
        let networkExpectation = expectation(description: "Wait until something happens.")
     
        let networkController = NetworkController()
        networkController.fetchPlanets
        { result in
            
            print("Closure called")
            
            switch result {
            case .failure(let error):
                XCTAssert(false)
                XCTFail()
                
            case .success(let planets):
                break
            }
            
            networkExpectation.fulfill()
        }
        
        // After we request a `fetchPlanets` call, we wait until the network returns.
        waitForExpectations(timeout: 5) { (possibleError: Error?) in
            // If the timeout is exceeded by `networkExpectation`
            
        }
        
    } // We reach the end of the function.
    
    func testFetchPlanetsFailure() {
        let networkExpectation = expectation(description: "Wait until something happens.")
     
        let networkController = NetworkController()
        networkController.fetchPlanets
        { result in
            
            print("Closure called")
            
            switch result {
            case .failure(let error):
                break
                
            case .success(let planets):
                XCTAssert(false)
                XCTFail()
            }
            
            networkExpectation.fulfill()
        }
        
        // After we request a `fetchPlanets` call, we wait until the network returns.
        waitForExpectations(timeout: 5) { (possibleError: Error?) in
            // If the timeout is exceeded by `networkExpectation`
            
        }
    }
    
}
