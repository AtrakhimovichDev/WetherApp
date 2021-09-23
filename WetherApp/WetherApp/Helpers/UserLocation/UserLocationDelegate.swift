//
//  LocationProtocol.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

protocol UserLocationDelegate: AnyObject {
    func didLocationUpdate(location: String)
}
