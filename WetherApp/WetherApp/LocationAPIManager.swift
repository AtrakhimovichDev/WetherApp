//
//  LocationAPIManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation

class LocationAPIManager {

    static let key = "f9bf6e6d2cda532bb98c599972196b58"
    static let defaultCity = "London"
    
    static func getLocationData(location: String) {
        let APIString = "http://api.positionstack.com/v1/reverse"
        let keysString = "access_key=\(key)&query=\(location)&limit=1"
        let URLString = "\(APIString)?\(keysString)"
        if let URlW = URL(string: URLString) {
            URLSession.shared.dataTask(with: URlW) { (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                if let location = try? JSONDecoder().decode(LocationA.self, from: data) {
                    // complition(wether)
                    print(location)
                }
            }.resume()
        }
    }
}
