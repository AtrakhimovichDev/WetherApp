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
    var didUpdateDataModel: ((WetherModel) -> Void)?
    var didUpdateDesignModel: ((DesignModel) -> Void)?

    var wetherModel: WetherModel? {
        didSet {
            if let wetherModel = wetherModel {
                DispatchQueue.main.async {
                    self.didUpdateDataModel?(wetherModel)
                }
            }
        }
    }

    private var designModel: DesignModel? {
        didSet {
            if let designModel = designModel {
                DispatchQueue.main.async {
                    self.didUpdateDesignModel?(designModel)
                }
            }
        }
    }

    override init() {
        super.init()
        createUserLocation()
    }

    func didLoad() {
        userLocation?.getUserLocation()
    }

    func updateData(location: String) {
        getWetherData(location: location)
    }

    private func createUserLocation() {
        let userLoc = UserLocationImplementation()
        userLoc.delegate = self
        userLocation = userLoc
    }

    private func getWetherData(location: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            WetherAPIManager.getWetherInfo(location: location, days: 7, complition: { wether in
                self.wetherModel = WetherModelsFactory.createWetherModel(wether: wether, location: location)
                self.designModel = DesignModelsFactory.createDesignModel(wether: wether)
            })
        }
    }
}

extension MainWetherViewModelImplementation: UserLocationDelegate {
    func didLocationUpdate(location: String) {
        getWetherData(location: location)
    }
}
