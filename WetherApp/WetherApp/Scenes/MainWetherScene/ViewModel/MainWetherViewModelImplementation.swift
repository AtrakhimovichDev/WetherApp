//
//  CurrentWetherViewModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import UIKit
import CoreLocation

class MainWetherViewModelImplementation: NSObject, MainWetherViewModel {

    var userLocation: UserLocation?
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
            WetherAPIManager.getWetherInfo(location: location, days: 7, complition: { wether in
                self.currentWether = WetherModelsFactory.createWetherModel(wether: wether, location: location)
                self.currentWetherDesign = DesignModelsFactory.createDesignModel(wether: wether)
            })
        }
    }
}

extension MainWetherViewModelImplementation: UserLocationDelegate {
    func didLocationUpdate(location: String) {
        getWetherData(location: location)
    }
}
