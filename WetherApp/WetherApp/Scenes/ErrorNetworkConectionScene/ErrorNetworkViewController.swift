//
//  ErrorNetworkViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 24.09.21.
//

import UIKit

class ErrorNetworkViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc private func handleRefreshControl() {
        if NetworkManager.checkNetworkConnection() {
            let viewController = ViewControllerFactory.viewController(for: .mainWether)
            navigationController?.pushViewController(viewController, animated: false)
        }
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
}
