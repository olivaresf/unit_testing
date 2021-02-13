//
//  NetworkSession.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 2/13/21.
//

import Foundation

class NetworkSession {
    let baseURL: String
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension NetworkSession : FetcherProtocol {
    
    func fetch(request: NetworkController.Request,
               completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlRequest: URLRequest
        switch request {
        case .planets:
            let url = URL(string: baseURL + "/planets")!
            urlRequest = URLRequest(url: url)
        default:
            return
        }
        
        let newTask = URLSession.shared.dataTask(with: urlRequest) { (possibleData, possibleResponse, possibleError) in
            
            guard possibleError == nil else {
                let error = NSError(domain: "NetworkError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let response = possibleResponse as? HTTPURLResponse else {
                let error = NSError(domain: "NetworkError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                let error = NSError(domain: "NetworkError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let receivedData = possibleData else {
                let error = NSError(domain: "NetworkError", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            completion(.success(receivedData))
        }
        
        newTask.resume()
    }
}
