//
//  DayWetherViewModelImplementation.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 14.09.21.
//

import Foundation

class DayWetherViewModelImplementation: DayWetherViewModel {

    var didUpdateCurrentWetherInfoModel: ((DayWetherModel) -> Void)?
    var didUpdateCurrentWetherDecorModel: ((WetherDesignModel) -> Void)?

    var wetherInfo: DayWetherModel? {
        didSet {
            if let wetherInfo = wetherInfo {
                DispatchQueue.main.async {
                    self.didUpdateCurrentWetherInfoModel?(wetherInfo)
                }
            }
        }
    }

    private var currentWetherDesign: WetherDesignModel? {
        didSet {
            if let currentWetherDecor = currentWetherDesign {
                DispatchQueue.main.async {
                    self.didUpdateCurrentWetherDecorModel?(currentWetherDecor)
                }
            }
        }
    }

    func didLoad() {
        DispatchQueue.global(qos: .userInteractive).async {
            WetherAPIManager.getWetherInfo(days: 1, complition: { wether in
                self.wetherInfo = DayWetherModel(
                    temperature: Int(wether.current.temperature),
                    condition: wether.current.condition.text,
                    detailedInfo: self.fillDetailedInfo(wether: wether),
                    astroInfo: self.fillAstroInfo(wether: wether),
                    hourForecast: self.fillHoursForecast(wether: wether))
                self.currentWetherDesign = self.createWetherDecorModel(wether: wether)
            })
        }
    }

    private func fillDetailedInfo(wether: Wether) -> [DetailedInfoModel] {
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

    private func fillAstroInfo(wether: Wether) -> [DetailedInfoModel] {
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

    private func createWetherDecorModel(wether: Wether) -> WetherDesignModel {
        var wetherDecorModel = WetherDesignModel()

        let wetherConditionCode = wether.current.condition.code
        let wetherCondition =  WetherConditionKeys.init(rawValue: wetherConditionCode)
        if let isGoodWether = wetherCondition?.isGoodWether() {
            if isGoodWether {
                if wether.current.isDay == 1 {
                    wetherDecorModel.backgroundImageName = "clear_day"
                    wetherDecorModel.conditionViewColor = .clearDayCondition
                    wetherDecorModel.collectionViewColor = .clearDayCollection
                } else {
                    wetherDecorModel.backgroundImageName = "clear_night"
                    wetherDecorModel.conditionViewColor = .clearNightCondition
                    wetherDecorModel.collectionViewColor = .clearNightCollection
                }
            } else {
                if wether.current.isDay == 1 {
                    wetherDecorModel.backgroundImageName = "cloudy_day"
                    wetherDecorModel.conditionViewColor = .cloudyDayCondition
                    wetherDecorModel.collectionViewColor = .cloudyDayCollection
                } else {
                    wetherDecorModel.backgroundImageName = "cloudy_night"
                    wetherDecorModel.conditionViewColor = .cloudyNightCondition
                    wetherDecorModel.collectionViewColor = .cloudyNightCollection
                }
            }
        }
        return wetherDecorModel
    }

    private func fillHoursForecast(wether: Wether) -> [HourForecastModel] {

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
