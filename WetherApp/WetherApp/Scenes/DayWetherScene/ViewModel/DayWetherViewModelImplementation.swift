//
//  DayWetherViewModelImplementation.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 14.09.21.
//

import Foundation
import CoreLocation

class DayWetherViewModelImplementation: NSObject, DayWetherViewModel {

    var userLocation: UserLocation?

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

    override init() {
        super.init()
        createUserLocation()
    }
    
    private func createUserLocation() {
        let userLoc = UserLocationImplementation()
        userLoc.delegate = self
        userLocation = userLoc
    }
    
    func didLoad() {
        userLocation?.getUserLocation()
    }

    private func getWetherData(location: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            WetherAPIManager.getWetherInfo(location: location, days: 1, complition: { wether in
                self.wetherInfo = WetherModelsFactory.createDayForecastModel(wether: wether, location: location)
                self.currentWetherDesign = DesignModelsFactory.createDesignModel(wether: wether)
            })
        }
    }
}

extension DayWetherViewModelImplementation: UserLocationDelegate {
    func didLocationUpdate(location: String) {
        getWetherData(location: location)
    }
}
