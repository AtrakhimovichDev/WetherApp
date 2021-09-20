//
//  HourlyForecastTableController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 20.09.21.
//

import UIKit

class HourlyForecastTableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    var wetherModel: DayWetherModel?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wetherModel?.hourForecast.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: HourForecastTableViewCell.identifier) as? HourForecastTableViewCell,
              let wetherModel = wetherModel else {
            return UITableViewCell()
        }

        let info = wetherModel.hourForecast[indexPath.row]
        cell.temperatureLabel.text = "\(info.temperature)°"
        cell.timeLabel.text = getTime(dateString: info.time)
        cell.wetherIcon.image = UIImage(named: info.wetherIconName)
        cell.selectionStyle = .none
        return cell
    }

    private func getTime(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            // dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
            let dayTime = dateFormatter.string(from: date)
            return dayTime
        }
        return "00:00"
    }
}
