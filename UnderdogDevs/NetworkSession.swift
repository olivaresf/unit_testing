//
//  NetworkSession.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 2/11/21.
//

import Foundation

class NetworkSession {
    let baseURL: String
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension NetworkSession : Fetcher {
    
    func fetch(request: NetworkController.Request, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = URL(string: baseURL + "/planets")!
        let request = URLRequest(url: url)
        let newTask = URLSession.shared.dataTask(with: request) { (possibleData, possibleResponse, possibleError) in
            
            guard possibleError == nil else {
                completion(.failure(possibleError!))
                return
            }
            
            guard let response = possibleResponse as? HTTPURLResponse else {
                let error = NSError(domain: "NetworkSession",
                                    code: 0,
                                    userInfo: [NSLocalizedFailureErrorKey: "Invalid HTTP URL code"])
                completion(.failure(error))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                let error = NSError(domain: "NetworkSession",
                                    code: response.statusCode,
                                    userInfo: [NSLocalizedFailureErrorKey: "Unexpected HTTP code (>200)"])
                completion(.failure(error))
                return
            }
            
            guard let receivedData = possibleData else {
                let error = NSError(domain: "NetworkSession",
                                    code: response.statusCode,
                                    userInfo: [NSLocalizedFailureErrorKey: "Invalid data"])
                completion(.failure(error))
                return
            }
            
            completion(.success(receivedData))
        }
        
        newTask.resume()
    }
}
