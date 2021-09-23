//
//  WetherModelsFactory.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

class WetherModelsFactory {

    static func createWetherModel(wether: Wether, location: String) -> MainWetherInfoModel {
        let wetherModel = MainWetherInfoModel(
            location: location,
            temperature: Int(wether.current.temperature),
            condition: wether.current.condition.text,
            daysForecast: self.fillDaysForecast(wether: wether))
        return wetherModel
    }

    static func createDayForecastModel(wether: Wether, location: String) -> DayWetherModel {
        let dayWetherModel = DayWetherModel(
            temperature: Int(wether.current.temperature),
            condition: wether.current.condition.text,
            detailedInfo: self.fillDetailedInfo(wether: wether),
            astroInfo: self.fillAstroInfo(wether: wether),
            hourForecast: self.fillHoursForecast(wether: wether))
        return dayWetherModel
    }

    private static func fillDaysForecast(wether: Wether) -> [DayForecastModel] {
        var daysForecatArray = [DayForecastModel]()
        let daysForecast = wether.forecast.forecastday

        for dayForecast in daysForecast {
            let dayForecast = createDayForecastModel(dayForecast: dayForecast,
                                                     isDay: wether.current.isDay)
            daysForecatArray.append(dayForecast)
        }
        return daysForecatArray
    }

    private static func createDayForecastModel(dayForecast: DailyWetherForecast, isDay: Int) -> DayForecastModel {
        var wetherIconName = ""

        let temperature = Int(dayForecast.day.averageTemperature)
        let dayName = CustomDateFormetter.getDayOfWeekName(dateString: dayForecast.date)
        let conditionCode = dayForecast.day.condition.code

        if let condition = WetherConditionKeys(rawValue: conditionCode) {
            let wetherIcon = condition.getIconCode()
            switch isDay {
            case 0:
                wetherIconName = "\(wetherIcon)n.png"
            default:
                wetherIconName = "\(wetherIcon)d.png"
            }
        }

        let dayForecastModel = DayForecastModel(temperature: temperature,
                                                day: dayName,
                                                wetherIconName: wetherIconName)
        return dayForecastModel
    }

    private static func fillDetailedInfo(wether: Wether) -> [DetailedInfoModel] {
        var infoArray = [DetailedInfoModel]()
        let feelslike = DetailedInfoModel(iconName: .temp,
                          propertyName: "Feelslike",
                          propertyValue: "\(Int(wether.current.feelslikeTemperature))°")
        let wind = DetailedInfoModel(iconName: .wind,
                          propertyName: "Wind",
                          propertyValue: "\(Int(wether.current.windSpeed))km/h  \(wether.current.windDirection)")
        let humidity = DetailedInfoModel(iconName: .humidity,
                          propertyName: "Humidity",
                          propertyValue: "\(wether.current.humidity)%")
        let pressure = DetailedInfoModel(iconName: .pressure,
                          propertyName: "Pressure",
                          propertyValue: "\(Int(wether.current.pressure)) mbar")
        infoArray.append(feelslike)
        infoArray.append(wind)
        infoArray.append(pressure)
        infoArray.append(humidity)
        return infoArray
    }

    private static func fillAstroInfo(wether: Wether) -> [DetailedInfoModel] {
        var infoArray = [DetailedInfoModel]()
        guard let astro = wether.forecast.forecastday.first?.astro else {
            return infoArray
        }
        let sunrise = DetailedInfoModel(iconName: .sunrise,
                          propertyName: "Sunrise",
                          propertyValue: "\(astro.sunrise)")
        let sunset = DetailedInfoModel(iconName: .sunset,
                          propertyName: "Sunset",
                          propertyValue: "\(astro.sunset)")
        let moonrise = DetailedInfoModel(iconName: .moonrise,
                          propertyName: "Moonrise",
                          propertyValue: "\(astro.moonrise)")
        let moonset = DetailedInfoModel(iconName: .moonset,
                          propertyName: "Moonset",
                          propertyValue: "\(astro.moonset)")
        infoArray.append(sunrise)
        infoArray.append(sunset)
        infoArray.append(moonrise)
        infoArray.append(moonset)
        return infoArray
    }

    private static func fillHoursForecast(wether: Wether) -> [HourForecastModel] {

        var hoursForecastArray = [HourForecastModel]()
        guard let dayForecast = wether.forecast.forecastday.first else {
            return hoursForecastArray
        }

        for hourForecast in dayForecast.hour {
            let temperature = Int(hourForecast.temperature)
            let condition = hourForecast.condition.text
            let conditionCode = hourForecast.condition.code
            var wetherIconName = "113d.png"
            if let condition = WetherConditionKeys(rawValue: conditionCode) {
                let wetherIcon = condition.getIconCode()
                switch wether.current.isDay {
                case 0:
                    wetherIconName = "\(wetherIcon)n.png"
                default:
                    wetherIconName = "\(wetherIcon)d.png"
                }
            }
            let time = hourForecast.time
            let forecast = HourForecastModel(time: time,
                                             condition: condition,
                                             wetherIconName: wetherIconName,
                                             temperature: temperature)
            hoursForecastArray.append(forecast)
        }
        return hoursForecastArray
    }
}
