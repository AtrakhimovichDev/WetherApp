//
//  Location.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

struct LocationA: Decodable {
    let data: [LocationData]
}

struct LocationData: Decodable {
    let region: String
    let locality: String
    let country: String
}
