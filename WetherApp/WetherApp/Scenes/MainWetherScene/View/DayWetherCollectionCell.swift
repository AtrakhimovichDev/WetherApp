//
//  DayWetherCollectionCell.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import UIKit

class DayWetherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var wetherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    static let identifier = "DayWetherCollectionCell"
}
