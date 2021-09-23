//
//  APIManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 16.08.21.
//

import Foundation

class WetherAPIManager {

    static let key = "34d767033f214178b1a101535212807"
    // static var language = Locale.preferredLanguages[0].prefix(2)
    static var language = "en"

    static func getWetherInfo(location: String, days: Int, complition: @escaping ((Wether) -> Void)) {
        let APIString = "https://api.weatherapi.com/v1/forecast.json"
        let keysString = "key=\(key)&q=\(location)&lang=\(language)&days=\(days)"
        var URLString = "\(APIString)?\(keysString)"
        URLString = URLString.replacingOccurrences(of: " ", with: "%20")
        if let URlW = URL(string: URLString) {
            URLSession.shared.dataTask(with: URlW) { (data, _, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                if let wether = try? JSONDecoder().decode(Wether.self, from: data) {
                    complition(wether)
                }
            }.resume()
        }
    }
}
