//
//  File.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 16.09.21.
//

import UIKit

class DetailedInfoTableController: NSObject, UITableViewDataSource, UITableViewDelegate {

    private var wetherInfoType: WetherInfoType = .wether
    var wetherModel: DayWetherModel?

    func changeWetherInfoType() {
        switch wetherInfoType {
        case .wether:
            wetherInfoType = .astro
        default:
            wetherInfoType = .wether
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch wetherInfoType {
        case .wether:
            return wetherModel?.detailedInfo.count ?? 0
        default:
            return wetherModel?.astroInfo.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell =
                tableView.dequeueReusableCell(
                    withIdentifier: DetailedInfoTableViewCell.identifier) as? DetailedInfoTableViewCell,
              let wetherModel = wetherModel else {
            return UITableViewCell()
        }
        switch wetherInfoType {
        case .wether:
            let info = wetherModel.detailedInfo[indexPath.row]
            cell.wetherPropertyLabel.text = info.propertyName
            cell.wetherPropertyValueLabel.text = info.propertyValue
            cell.iconButton.setBackgroundImage(UIImage(systemName: info.iconName.rawValue), for: .normal)
        default:
            let info = wetherModel.astroInfo[indexPath.row]
            cell.wetherPropertyLabel.text = info.propertyName
            cell.wetherPropertyValueLabel.text = info.propertyValue
            cell.iconButton.setBackgroundImage(UIImage(systemName: info.iconName.rawValue), for: .normal)
        }
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
