//
//  CustomDateFormatter.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 20.09.21.
//

import Foundation

class CustomDateFormetter {

    static func getDayOfWeekName(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEE"
            // dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
            let dayName = dateFormatter.string(from: date)
            return dayName
        }
        return "MON"
    }
}
