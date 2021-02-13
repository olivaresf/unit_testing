//
//  MockSession.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 2/13/21.
//

import Foundation
@testable import UnderdogDevs

class MockSession {
    let data: Data
    init(data: Data) {
        self.data = data
    }
}

extension MockSession : FetcherProtocol {
    
    func fetch(request: NetworkController.Request, completion: @escaping (Result<Data, Error>) -> Void) {
    
        // Test however I want to test.
        // 1. Return empty data.
        // 2. Return an invalid JSON
        // 3. Return 100 planets
        // 3. Return no planets.
        
        // Get the data from wherever.
        // 1. Setup my own core data.
        // 2. Setup SQLite
        // 3. Setup an array directly disk
        
        completion(.success(data))
    }
}
