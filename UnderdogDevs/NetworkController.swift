//
//  NetworkController.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 12/15/20.
//

import Foundation

protocol FetcherProtocol {
    func fetch(request: NetworkController.Request, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkController {
    
    let baseURL: String
    init(baseURL: String = "https://swapi.dev/api") {
        self.baseURL = baseURL
    }
    
    enum FetchError : Error {
        case fetcherError(Error)
        case invalidJSON(Error)
    }
    
    enum Request {
        case planets
    }
    
    func fetchPlanets(someFetcher: FetcherProtocol = NetworkSession(baseURL: "https://swapi.dev/api"),
                      completion: @escaping (Result<[Planet], FetchError>) -> Void) {
        
        someFetcher.fetch(request: .planets) { result in
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let planetsResult = try decoder.decode(PlanetResult.self, from: data)
                    completion(.success(planetsResult.results))
                } catch {
                    completion(.failure(.invalidJSON(error)))
                }
                
            case .failure(let error):
                completion(.failure(.fetcherError(error)))
            }
            
        }
    }
}
