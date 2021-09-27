//
//  CityModelsFactory.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

class CityModelsFactory {
    
    static func createCityModel(cities: [CityJSON]) -> CityModel {
        var citiesArray = [City]()
        for element in cities {
            let city = City(city: element.name, country: element.country)
            citiesArray.append(city)
        }
        let cityModel = CityModel(cities: citiesArray)
        return cityModel
    }
}
