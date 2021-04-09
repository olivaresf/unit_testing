//
//  NetworkController.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 12/15/20.
//

import Foundation

protocol NetworkControllerDelegate {
    func fetch(resourceType: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkController {
    
    let baseURL: String
    init(baseURL: String = "https://swapi.dev/api") {
        self.baseURL = baseURL
    }
    
    enum FetchError : Error {
        case network(Error)
        case missingResponse
        case unexpectedResponse(Int)
        case invalidData
        case invalidJSON(Error)
    }
    
    // Protocols are _not_ types.

    func fetchPlanets(anObject: NetworkControllerDelegate,
                      completion: @escaping (Result<[Planet], Error>) -> Void) {
    
        // Why am I deleting all of this?
        // So you, as a developer, can pass along _any_ data.
        
        // anObject = URLSession -> Network
        // anObject = MockSession -> We don't need to go out to the network
        anObject.fetch(resourceType: baseURL + "/planets") { result in
            
            switch result {
            
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let planetsResult = try decoder.decode(PlanetResult.self, from: data)
                    completion(.success(planetsResult.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

extension URLSession : NetworkControllerDelegate {
    
    func fetch(resourceType: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        // Creating the URL and its request.
        let url = URL(string: resourceType)!
        let request = URLRequest(url: url)
        let newTask = URLSession.shared.dataTask(with: request) { (possibleData, possibleResponse, possibleError) in
            
            guard possibleError == nil else {
                completion(.failure(NetworkController.FetchError.network(possibleError!)))
                return
            }
            
            guard let response = possibleResponse as? HTTPURLResponse else {
                completion(.failure(NetworkController.FetchError.missingResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkController.FetchError.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedData = possibleData else {
                completion(.failure(NetworkController.FetchError.invalidData))
                return
            }
            
            completion(.success(receivedData))
        }
        
        // Sending the request.
        newTask.resume()
    }

}
