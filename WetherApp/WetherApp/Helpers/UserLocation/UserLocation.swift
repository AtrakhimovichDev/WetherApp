//
//  UserLocationProtocol.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

protocol UserLocation {
    var delegate: UserLocationDelegate? { get set }
    func getUserLocation()
}
