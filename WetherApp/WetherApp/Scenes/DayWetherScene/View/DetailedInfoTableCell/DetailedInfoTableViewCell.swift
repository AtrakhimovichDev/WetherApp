//
//  DetailedInfoTableViewCell.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 14.09.21.
//

import UIKit

class DetailedInfoTableViewCell: UITableViewCell {

    static let identifier = "DetailedInfoTableViewCell"

    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var wetherPropertyValueLabel: UILabel!
    @IBOutlet weak var wetherPropertyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
