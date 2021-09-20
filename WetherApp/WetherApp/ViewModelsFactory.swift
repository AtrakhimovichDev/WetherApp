//
//  ViewModelsFactory.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 14.09.21.
//

import UIKit

class ViewModelsFactory {

    static func createDayWetherViewModel() -> DayWetherViewModel {
        let viewModel = DayWetherViewModelImplementation()
        return viewModel
    }

    static func createMainWetherViewModel() -> MainWetherViewModel {
        let viewModel = MainWetherViewModelImplementation()
        return viewModel
    }
}
