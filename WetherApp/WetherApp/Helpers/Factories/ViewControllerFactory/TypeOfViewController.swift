//
//  TypeOfViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

enum TypeOfViewController {
    case mainWether
    case detailedWether
    case citySearch
    case errorNetworkConnection
}

extension TypeOfViewController {
    func storyboardRepresentation() -> StoryboardRepresentation {
        switch self {
        case .mainWether:
            return StoryboardRepresentation(storyboardId: "MainWetherViewController", bundle: nil)
        case .detailedWether:
            return StoryboardRepresentation(storyboardId: "DayWetherViewController", bundle: nil)
        case .errorNetworkConnection:
            return StoryboardRepresentation(storyboardId: "ErrorNetworkViewController", bundle: nil)
        case .citySearch:
            return StoryboardRepresentation(storyboardId: "CitySearchViewController", bundle: nil)
        }
    }
}
