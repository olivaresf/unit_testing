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
        networkController.fetchPlanets(anObject: URLSession.shared) { result in
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
    
    func testFailurePlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        let error = NSError(domain: "Oh no", code: 500, userInfo: nil)
        let mockSession = MockSession(result: .failure(error))
        networkController.fetchPlanets(anObject: mockSession) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    } // The end of the function ✅
    
    func testFailureWithEmptyDataPlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let networkController = NetworkController()
        let mockSession = MockSession(result: .success(Data()))
        networkController.fetchPlanets(anObject: mockSession) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    } // The end of the function ✅
    
    func testFailureWithCorruptJSONPlanetFetch() throws {
        
        // Allows us to continue to the end of the function.
        let expectation = self.expectation(description: "Waiting for planets")
        
        let invalidJSONString = """
        
        
            "count": 60,
            "next": "http://swapi.dev/api/planets/?page=2",
            "previous": null,
            "results": [
                {
                    "name": "Tatooine",
                    "rotation_period": "23",
                    "orbital_period": "304",
                    "diameter": "10465",
                    "climate": "arid",
                    "gravity": "1 standard",
                    "terrain": "desert",
                    "surface_water": "1",
                    "population": "200000",
                    "residents": [
                        "http://swapi.dev/api/people/1/",
                        "http://swapi.dev/api/people/2/",
                        "http://swapi.dev/api/people/4/",
                        "http://swapi.dev/api/people/6/",
                        "http://swapi.dev/api/people/7/",
                        "http://swapi.dev/api/people/8/",
                        "http://swapi.dev/api/people/9/",
                        "http://swapi.dev/api/people/11/",
                        "http://swapi.dev/api/people/43/",
                        "http://swapi.dev/api/people/62/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/1/",
                        "http://swapi.dev/api/films/3/",
                        "http://swapi.dev/api/films/4/",
                        "http://swapi.dev/api/films/5/",
                        "http://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-09T13:50:49.641000Z",
                    "edited": "2014-12-20T20:58:18.411000Z",
                    "url": "http://swapi.dev/api/planets/1/"
                },
                {
                    "name": "Alderaan",
                    "rotation_period": "24",
                    "orbital_period": "364",
                    "diameter": "12500",
                    "climate": "temperate",
                    "gravity": "1 standard",
                    "terrain": "grasslands, mountains",
                    "surface_water": "40",
                    "population": "2000000000",
                    "residents": [
                        "http://swapi.dev/api/people/5/",
                        "http://swapi.dev/api/people/68/",
                        "http://swapi.dev/api/people/81/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/1/",
                        "http://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-10T11:35:48.479000Z",
                    "edited": "2014-12-20T20:58:18.420000Z",
                    "url": "http://swapi.dev/api/planets/2/"
                },
                {
                    "name": "Yavin IV",
                    "rotation_period": "24",
                    "orbital_period": "4818",
                    "diameter": "10200",
                    "climate": "temperate, tropical",
                    "gravity": "1 standard",
                    "terrain": "jungle, rainforests",
                    "surface_water": "8",
                    "population": "1000",
                    "residents": [],
                    "films": [
                        "http://swapi.dev/api/films/1/"
                    ],
                    "created": "2014-12-10T11:37:19.144000Z",
                    "edited": "2014-12-20T20:58:18.421000Z",
                    "url": "http://swapi.dev/api/planets/3/"
                },
                {
                    "name": "Hoth",
                    "rotation_period": "23",
                    "orbital_period": "549",
                    "diameter": "7200",
                    "climate": "frozen",
                    "gravity": "1.1 standard",
                    "terrain": "tundra, ice caves, mountain ranges",
                    "surface_water": "100",
                    "population": "unknown",
                    "residents": [],
                    "films": [
                        "http://swapi.dev/api/films/2/"
                    ],
                    "created": "2014-12-10T11:39:13.934000Z",
                    "edited": "2014-12-20T20:58:18.423000Z",
                    "url": "http://swapi.dev/api/planets/4/"
                },
                {
                    "name": "Dagobah",
                    "rotation_period": "23",
                    "orbital_period": "341",
                    "diameter": "8900",
                    "climate": "murky",
                    "gravity": "N/A",
                    "terrain": "swamp, jungles",
                    "surface_water": "8",
                    "population": "unknown",
                    "residents": [],
                    "films": [
                        "http://swapi.dev/api/films/2/",
                        "http://swapi.dev/api/films/3/",
                        "http://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-10T11:42:22.590000Z",
                    "edited": "2014-12-20T20:58:18.425000Z",
                    "url": "http://swapi.dev/api/planets/5/"
                },
                {
                    "name": "Bespin",
                    "rotation_period": "12",
                    "orbital_period": "5110",
                    "diameter": "118000",
                    "climate": "temperate",
                    "gravity": "1.5 (surface), 1 standard (Cloud City)",
                    "terrain": "gas giant",
                    "surface_water": "0",
                    "population": "6000000",
                    "residents": [
                        "http://swapi.dev/api/people/26/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/2/"
                    ],
                    "created": "2014-12-10T11:43:55.240000Z",
                    "edited": "2014-12-20T20:58:18.427000Z",
                    "url": "http://swapi.dev/api/planets/6/"
                },
                {
                    "name": "Endor",
                    "rotation_period": "18",
                    "orbital_period": "402",
                    "diameter": "4900",
                    "climate": "temperate",
                    "gravity": "0.85 standard",
                    "terrain": "forests, mountains, lakes",
                    "surface_water": "8",
                    "population": "30000000",
                    "residents": [
                        "http://swapi.dev/api/people/30/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/3/"
                    ],
                    "created": "2014-12-10T11:50:29.349000Z",
                    "edited": "2014-12-20T20:58:18.429000Z",
                    "url": "http://swapi.dev/api/planets/7/"
                },
                {
                    "name": "Naboo",
                    "rotation_period": "26",
                    "orbital_period": "312",
                    "diameter": "12120",
                    "climate": "temperate",
                    "gravity": "1 standard",
                    "terrain": "grassy hills, swamps, forests, mountains",
                    "surface_water": "12",
                    "population": "4500000000",
                    "residents": [
                        "http://swapi.dev/api/people/3/",
                        "http://swapi.dev/api/people/21/",
                        "http://swapi.dev/api/people/35/",
                        "http://swapi.dev/api/people/36/",
                        "http://swapi.dev/api/people/37/",
                        "http://swapi.dev/api/people/38/",
                        "http://swapi.dev/api/people/39/",
                        "http://swapi.dev/api/people/42/",
                        "http://swapi.dev/api/people/60/",
                        "http://swapi.dev/api/people/61/",
                        "http://swapi.dev/api/people/66/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/3/",
                        "http://swapi.dev/api/films/4/",
                        "http://swapi.dev/api/films/5/",
                        "http://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-10T11:52:31.066000Z",
                    "edited": "2014-12-20T20:58:18.430000Z",
                    "url": "http://swapi.dev/api/planets/8/"
                },
                {
                    "name": "Coruscant",
                    "rotation_period": "24",
                    "orbital_period": "368",
                    "diameter": "12240",
                    "climate": "temperate",
                    "gravity": "1 standard",
                    "terrain": "cityscape, mountains",
                    "surface_water": "unknown",
                    "population": "1000000000000",
                    "residents": [
                        "http://swapi.dev/api/people/34/",
                        "http://swapi.dev/api/people/55/",
                        "http://swapi.dev/api/people/74/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/3/",
                        "http://swapi.dev/api/films/4/",
                        "http://swapi.dev/api/films/5/",
                        "http://swapi.dev/api/films/6/"
                    ],
                    "created": "2014-12-10T11:54:13.921000Z",
                    "edited": "2014-12-20T20:58:18.432000Z",
                    "url": "http://swapi.dev/api/planets/9/"
                },
                {
                    "name": "Kamino",
                    "rotation_period": "27",
                    "orbital_period": "463",
                    "diameter": "19720",
                    "climate": "temperate",
                    "gravity": "1 standard",
                    "terrain": "ocean",
                    "surface_water": "100",
                    "population": "1000000000",
                    "residents": [
                        "http://swapi.dev/api/people/22/",
                        "http://swapi.dev/api/people/72/",
                        "http://swapi.dev/api/people/73/"
                    ],
                    "films": [
                        "http://swapi.dev/api/films/5/"
                    ],
                    "created": "2014-12-10T12:45:06.577000Z",
                    "edited": "2014-12-20T20:58:18.434000Z",
                    "url": "http://swapi.dev/api/planets/10/"
                }
            ]
        }

        """
        
        let invalidJSONData = invalidJSONString.data(using: .utf8)
        
        let networkController = NetworkController()
        let mockSession = MockSession(result: .success(invalidJSONData!))
        networkController.fetchPlanets(anObject: mockSession) { (result) in
            switch result {
            
            case .failure(let error):
                print("All is going according to plan: \(error)")
                
            case .success:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { possibleError in
            print("Finished waiting: \(String(describing: possibleError))")
        }
        
    } // The end of the function ✅
    
}
