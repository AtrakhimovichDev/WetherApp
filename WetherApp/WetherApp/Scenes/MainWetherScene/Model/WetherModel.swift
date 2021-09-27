//
//  CurrentWetherModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import Foundation

struct WetherModel {
    let location: String
    let temperature: Int
    let condition: String
    let daysForecast: [DayForecastModel]
}
