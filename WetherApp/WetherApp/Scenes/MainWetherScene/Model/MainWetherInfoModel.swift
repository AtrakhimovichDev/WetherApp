//
//  CurrentWetherModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import Foundation

struct MainWetherInfoModel {
    let temperature: Int
    let condition: String
    let daysForecast: [DayForecastModel]
}
