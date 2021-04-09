//
//  MockSession.swift
//  UnderdogDevsTests
//
//  Created by Fernando Olivares on 4/8/21.
//

import Foundation
@testable import UnderdogDevs

class MockSession {
    
    let result: Result<Data, Error>
    init(result: Result<Data, Error>) {
        self.result = result
    }
    
}

extension MockSession : NetworkControllerDelegate {
    func fetch(resourceType: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.result)
        }
    }
}
