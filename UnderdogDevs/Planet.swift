//
//  Planet.swift
//  UnderdogDevs
//
//  Created by Fernando Olivares on 12/15/20.
//

import Foundation

struct PlanetResult : Codable {
    let results: [Planet]
}

struct Planet : Codable {
    let name: String
}
