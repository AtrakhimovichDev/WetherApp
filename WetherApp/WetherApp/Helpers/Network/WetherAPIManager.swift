//
//  APIManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 16.08.21.
//

import Foundation
import Alamofire

class WetherAPIManager {

    static let key = "34d767033f214178b1a101535212807"
    static var language = "en"
    // static var language = Locale.preferredLanguages[0].prefix(2)

    static func getWetherInfo(location: String, days: Int, complition: @escaping ((Wether) -> Void)) {

        let URLString = "https://api.weatherapi.com/v1/forecast.json"
        let parameters = ["key": key,
                          "q": location,
                          "lang": language,
                          "days": "\(days)"]

        AF.request(URLString, parameters: parameters).response { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if let wether = try? JSONDecoder().decode(Wether.self, from: data) {
               complition(wether)
            }
        }
    }
}
