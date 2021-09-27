//
//  Cur.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import Foundation

protocol MainWetherViewModel {
    var wetherModel: WetherModel? { get set }
    var didUpdateDataModel: ((WetherModel) -> Void)? { get set }
    var didUpdateDesignModel: ((DesignModel) -> Void)? { get set }
    func didLoad()
    func updateData(location: String)
}
