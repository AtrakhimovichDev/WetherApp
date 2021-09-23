//
//  ForecastWether.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 15.08.21.
//

import Foundation

struct ForecastWether: Decodable {
    let forecastday: [DailyWetherForecast]
}

struct DailyWetherForecast: Decodable {
    let date: String
    let day: AverageDayWether
    let astro: AstroInfo
    let hour: [HourWether]
}
