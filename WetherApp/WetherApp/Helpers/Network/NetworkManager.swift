//
//  NetworkManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation
import Alamofire

class NetworkManager {
    static func checkNetworkConnection() -> Bool {
        if NetworkReachabilityManager()!.isReachable {
            return true
        } else {
            return false
        }
    }
}
