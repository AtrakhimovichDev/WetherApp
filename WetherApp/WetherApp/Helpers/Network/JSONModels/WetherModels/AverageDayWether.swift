//
//  AverageDayWether.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

struct AverageDayWether: Decodable {
    let maxTemperature: Double
    let minTemperature: Double
    let averageTemperature: Double
    let chanceOfRain: Int
    let condition: WetherCondition

    enum CodingKeys: String, CodingKey {
        case condition
        case maxTemperature = "maxtemp_c"
        case minTemperature = "mintemp_c"
        case averageTemperature = "avgtemp_c"
        case chanceOfRain = "daily_chance_of_rain"
    }
}
