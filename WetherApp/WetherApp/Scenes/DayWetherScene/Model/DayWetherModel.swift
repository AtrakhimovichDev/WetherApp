//
//  DayWetherModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 11.09.21.
//

import Foundation

struct DayWetherModel {
    let temperature: Int
    let condition: String
    let detailedInfo: [DetailedInfoModel]
    let astroInfo: [DetailedInfoModel]
    let hourForecast: [HourForecastModel]
}
