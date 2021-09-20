//
//  DetailedWetherInfoView.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 14.09.21.
//

import UIKit

class DetailedWetherInfoView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        Bundle(for: DetailedWetherInfoView.self)
            .loadNibNamed(String(describing: DetailedWetherInfoView.self),
                          owner: self, options: [:])
        #if TARGET_INTERFASE_BUILDER
        tableView.dataSource = self
        contentView.frame = self.bounds
        self.addSubview(contentView)
        #else
        contentView.fixInContainer(self)
        #endif
    }
}

extension DetailedWetherInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // cell.setValue("Hello", forKey: "textLabel")
        return cell
    }
}
