//
//  CityViewModelImplementation.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

class CityViewModelImplementation: NSObject, CityViewModel {

    var didUpdateDataModel: ((CityModel) -> Void)?
    var didUpdateDesignModel: ((DesignModel) -> Void)?

    var cityModel: CityModel? {
        didSet {
            if let cityModel = cityModel {
                DispatchQueue.main.async {
                    self.didUpdateDataModel?(cityModel)
                }
            }
        }
    }

    private var designModel: DesignModel? {
        didSet {
            if let designModel = designModel {
                DispatchQueue.main.async {
                    self.didUpdateDesignModel?(designModel)
                }
            }
        }
    }

    func didLoad() {
        getCitiesData()
    }

    func getCitiesCount() -> Int {
        return cityModel?.cities.count ?? 0
    }

    func getFilteredCitiesCount() -> Int {
        return cityModel?.filteredCities.count ?? 0
    }

    func filterCities(searchText: String) {
        guard let cityModel = cityModel else { return }
        let filteredCities = cityModel.cities.filter {
            $0.city.lowercased().contains(searchText.lowercased()) }
        self.cityModel?.filteredCities = filteredCities
    }

    private func getCitiesData() {
        DispatchQueue.global(qos: .userInteractive).async {
            CitiesAPIManager.getCitiesData { cities in
                self.cityModel = CityModelsFactory.createCityModel(cities: cities)
            }
        }
    }
}
