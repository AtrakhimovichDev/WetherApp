//
//  UserDefaultsManager.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import Foundation

class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard

    func getUserSetting(type: UserSettings) -> Any? {
        let result = userDefaults.object(forKey: type.rawValue)
        return result
    }

    func setUserSetting(type: UserSettings, value: Any) {
        userDefaults.setValue(value, forKey: type.rawValue)
    }
}
