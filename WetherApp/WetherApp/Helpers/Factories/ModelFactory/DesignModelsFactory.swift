//
//  DesignModelFactory.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

class DesignModelsFactory {

    static func createDesignModel(wether: Wether) -> DesignModel {
        var wetherDesignModel = DesignModel()

        let wetherConditionCode = wether.current.condition.code
        let wetherCondition =  WetherConditionKeys.init(rawValue: wetherConditionCode)
        if let isGoodWether = wetherCondition?.isGoodWether() {
            if isGoodWether {
                if wether.current.isDay == 1 {
                    wetherDesignModel.backgroundImageName = "clear_day"
                    wetherDesignModel.conditionViewColor = .clearDayCondition
                    wetherDesignModel.collectionViewColor = .clearDayCollection
                } else {
                    wetherDesignModel.backgroundImageName = "clear_night"
                    wetherDesignModel.conditionViewColor = .clearNightCondition
                    wetherDesignModel.collectionViewColor = .clearNightCollection
                }
            } else {
                if wether.current.isDay == 1 {
                    wetherDesignModel.backgroundImageName = "cloudy_day"
                    wetherDesignModel.conditionViewColor = .cloudyDayCondition
                    wetherDesignModel.collectionViewColor = .cloudyDayCollection
                } else {
                    wetherDesignModel.backgroundImageName = "cloudy_night"
                    wetherDesignModel.conditionViewColor = .cloudyNightCondition
                    wetherDesignModel.collectionViewColor = .cloudyNightCollection
                }
            }
        }
        return wetherDesignModel
    }
}
