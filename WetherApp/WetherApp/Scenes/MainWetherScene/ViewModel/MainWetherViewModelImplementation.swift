//
//  CurrentWetherViewModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import UIKit
import CoreLocation

class MainWetherViewModelImplementation: NSObject, MainWetherViewModel {

    let locationManager = CLLocationManager()

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
        getDeviceLocation()
        // getWetherData()
    }

    private func getDeviceLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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

    private func sendLocationRequest(location: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            LocationAPIManager.getLocationData(location: location)
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

extension MainWetherViewModelImplementation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            sendLocationRequest(location: "\(latitude),\(longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
}
