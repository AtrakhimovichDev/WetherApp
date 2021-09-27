//
//  AstroInfo.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

struct AstroInfo: Decodable {
    let sunrise: String
    let sunset: String
    let moonrise: String
    let moonset: String
}
