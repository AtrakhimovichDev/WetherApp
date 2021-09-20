//
//  Wether.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

struct Wether: Decodable {
    let current: CurrentWether
    let forecast: ForecastWether
}
