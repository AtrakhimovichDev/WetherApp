//
//  CitiesAPIManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation
import Alamofire

class CitiesAPIManager {

    static func getCitiesData(complition: @escaping (([CityJSON]) -> Void)) {
        let URLString = "https://pkgstore.datahub.io/core/world-cities/world-cities_json/data/5b3dd46ad10990bca47b04b4739a02ba/world-cities_json.json"

        AF.request(URLString).response { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if let cities = try? JSONDecoder().decode([CityJSON].self, from: data) {
                complition(cities)
            }
        }
    }
}
