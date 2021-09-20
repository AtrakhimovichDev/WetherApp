//
//  CurrentWetherViewModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import Foundation
import UIKit

class MainWetherViewModelImplementation: MainWetherViewModel {

    var didUpdateCurrentWetherInfoModel: ((MainWetherInfoModel) -> Void)?
    var didUpdateCurrentWetherDecorModel: ((WetherDesignModel) -> Void)?

    var currentWether: MainWetherInfoModel? {
        didSet {
            if let currentWether = currentWether {
                DispatchQueue.main.async {
                    self.didUpdateCurrentWetherInfoModel?(currentWether)
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
        getWetherData()
    }

    private func getWetherData() {
        DispatchQueue.global(qos: .userInteractive).async {
            WetherAPIManager.getWetherInfo(days: 7, complition: { wether in
                self.currentWether = MainWetherInfoModel(
                    temperature: Int(wether.current.temperature),
                    condition: wether.current.condition.text,
                    daysForecast: self.fillDaysForecast(wether: wether))
                self.currentWetherDesign = self.createWetherDecorModel(wether: wether)
            })
        }
    }

    private func fillDaysForecast(wether: Wether) -> [DayForecastModel] {
        var daysForecatArray = [DayForecastModel]()
        let daysForecast = wether.forecast.forecastday

        for dayForecast in daysForecast {
            let dayForecast = createDayForecastModel(dayForecast: dayForecast,
                                                     isDay: wether.current.isDay)
            daysForecatArray.append(dayForecast)
        }
        return daysForecatArray
    }

    private func createDayForecastModel(dayForecast: DailyWetherForecast, isDay: Int) -> DayForecastModel {
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
}
