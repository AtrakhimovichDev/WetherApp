//
//  HourForecastTableViewCell.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 16.09.21.
//

import UIKit

class HourForecastTableViewCell: UITableViewCell {

    static let identifier = "HourForecastTableViewCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var wetherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
