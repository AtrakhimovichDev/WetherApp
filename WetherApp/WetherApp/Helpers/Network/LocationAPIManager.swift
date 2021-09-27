//
//  LocationAPIManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation
import Alamofire

class LocationAPIManager {

    static let key = "f9bf6e6d2cda532bb98c599972196b58"
    static let defaultCity = "London"

    static func getLocationData(location: String, complition: @escaping ((String) -> Void)) {
        let URLString = "http://api.positionstack.com/v1/reverse"
        let parameters = ["access_key": key,
                          "query": location,
                          "limit": "1"]

        AF.request(URLString, parameters: parameters).response { response in
            if let error = response.error {
                print(error.localizedDescription)
                complition(defaultCity)
                return
            }
            guard let data = response.data else { return }
            if let location = try? JSONDecoder().decode(Location.self, from: data),
               let city = location.data.first?.locality {
                complition(city)
            } else {
                complition(defaultCity)
            }
        }
    }
}
