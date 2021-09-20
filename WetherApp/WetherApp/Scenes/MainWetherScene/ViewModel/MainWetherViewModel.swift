//
//  Cur.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import Foundation

protocol MainWetherViewModel {
    var currentWether: MainWetherInfoModel? { get set }
    var didUpdateCurrentWetherInfoModel: ((MainWetherInfoModel) -> Void)? { get set }
    var didUpdateCurrentWetherDecorModel: ((WetherDesignModel) -> Void)? { get set }
    func didLoad()
}
