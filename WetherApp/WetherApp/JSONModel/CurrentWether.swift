//
//  Wether.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

struct CurrentWether: Decodable {
    let temperature: Double
    let feelslikeTemperature: Double
    let isDay: Int
    let condition: WetherCondition
    let windSpeed: Double
    let windDirection: String
    let pressure: Double
    let humidity: Int
    let cloud: Int

    enum CodingKeys: String, CodingKey {
        case condition, humidity, cloud
        case temperature = "temp_c"
        case isDay = "is_day"
        case windSpeed = "wind_kph"
        case windDirection = "wind_dir"
        case pressure = "pressure_mb"
        case feelslikeTemperature = "feelslike_c"
    }
}
