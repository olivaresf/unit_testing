//
//  MockSession.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 2/11/21.
//

import Foundation
@testable import UnderdogDevs

class MockSession {
    let jsonString: String
    init(jsonString: String) {
        self.jsonString = jsonString
    }
}

extension MockSession : Fetcher {
    func fetch(request: NetworkController.Request, completion: @escaping (Result<Data, Error>) -> Void) {
        // Where?
        // 1. Read from a file.
        // 2. Create our own string.
        // 3. Build a core data store.
        // 4. Build our own database
        
        // What data?
        // Empty data?
        // Corrupt JSON?
        // 10 Planets?
        let succesfulJSONData = jsonString.data(using: .utf8)!
        
        completion(.success(succesfulJSONData))
    }
}
