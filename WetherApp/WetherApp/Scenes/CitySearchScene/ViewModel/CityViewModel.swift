//
//  CityViewModel.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

protocol CityViewModel {
    var cityModel: CityModel? { get set }
    var didUpdateDataModel: ((CityModel) -> Void)? { get set }
    var didUpdateDesignModel: ((DesignModel) -> Void)? { get set }
    func didLoad()
    func getCitiesCount() -> Int
    func getFilteredCitiesCount() -> Int
    func filterCities(searchText: String)
}
