//
//  NetworkController.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 12/15/20.
//

import Foundation

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
    
    func fetchPlanets(completion: @escaping (Result<[Planet], FetchError>) -> Void) {
        
        let url = URL(string: baseURL + "/planets")!
        let request = URLRequest(url: url)
        let newTask = URLSession.shared.dataTask(with: request) { (possibleData, possibleResponse, possibleError) in
            
            guard possibleError == nil else {
                completion(.failure(.network(possibleError!)))
                return
            }
            
            guard let response = possibleResponse as? HTTPURLResponse else {
                completion(.failure(.missingResponse))
                return
            }
            
            // HTTP Codes -> 200-299 OK
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.unexpectedResponse(response.statusCode)))
                return
            }
            
            guard let receivedData = possibleData else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let planetsResult = try decoder.decode(PlanetResult.self, from: receivedData)
                completion(.success(planetsResult.results))
            } catch {
                completion(.failure(.invalidJSON(error)))
            }
        }
        
        newTask.resume()
    }
}
