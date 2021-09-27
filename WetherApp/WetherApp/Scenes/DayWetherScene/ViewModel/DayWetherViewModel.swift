//
//  DayWetherViewModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 11.09.21.
//

import Foundation

protocol DayWetherViewModel {
    var wetherInfo: DayWetherModel? { get set }
    var didUpdateCurrentWetherInfoModel: ((DayWetherModel) -> Void)? { get set }
    var didUpdateCurrentWetherDecorModel: ((DesignModel) -> Void)? { get set }
    func didLoad()
}
