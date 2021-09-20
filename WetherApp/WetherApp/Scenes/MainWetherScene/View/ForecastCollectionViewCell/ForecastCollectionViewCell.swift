//
//  ForecastCollectionViewCell.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 17.08.21.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    static var identifier = "ForecastCollectionViewCell"

    @IBOutlet weak var wetherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        temperatureLabel.textColor = .white
        dayLabel.textColor = .white
    }

    func fillInfo(dayForecast: DayForecastModel) {
        let image = UIImage(named: dayForecast.wetherIconName)
        wetherImage.image = image
        temperatureLabel.text = String(dayForecast.temperature)
        dayLabel.text = dayForecast.day
    }

}
