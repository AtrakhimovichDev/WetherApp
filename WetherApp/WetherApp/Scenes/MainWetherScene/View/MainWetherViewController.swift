//
//  ViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 29.07.21.
//

import UIKit

class MainWetherViewController: UIViewController {

    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: MainWetherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViewModelSettings()
        setupViewControllerSetting()
        viewModel?.didLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didUpdateLocation(_:)),
                                               name: .didUpdateLocation,
                                               object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupViewModelSettings() {
        viewModel = ViewModelsFactory.createMainWetherViewModel()
        viewModel?.didUpdateDataModel = { wetherModel in
            self.temperatureLabel.text = String(wetherModel.temperature)
            self.conditionLabel.text = wetherModel.condition
            self.collectionView.reloadData()
            self.cityButton.setTitle(wetherModel.location, for: .normal)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        viewModel?.didUpdateDesignModel = { wetherDecor in
            self.backgroundImageView.image = UIImage(named: wetherDecor.backgroundImageName)
            let conditionColorString = wetherDecor.conditionViewColor.rawValue
            self.conditionView.backgroundColor = UIColor.hexStringToUIColor(
                hex: conditionColorString)
            let collectionColorString = wetherDecor.collectionViewColor.rawValue
            self.collectionViewContainer.backgroundColor = UIColor.hexStringToUIColor(hex: collectionColorString)
        }
    }

    private func setupViewControllerSetting() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibName = String(describing: ForecastCollectionViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        conditionView.layer.cornerRadius = 15
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(temperatureLabelTap))
        temperatureLabel.isUserInteractionEnabled = true
        temperatureLabel.addGestureRecognizer(tapGesture)
    }

    @objc func temperatureLabelTap(sender: UITapGestureRecognizer) {
        let viewController = ViewControllerFactory.viewController(for: .detailedWether)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func didUpdateLocation(_ notification: Notification) {
        if let data = notification.userInfo as? [String: String],
           let city = data["City"] {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            viewModel?.updateData(location: city)
        }
    }

    @IBAction func cityButtonPressed(_ sender: Any) {
        let viewController = ViewControllerFactory.viewController(for: .citySearch)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MainWetherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.wetherModel?.daysForecast.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier,
            for: indexPath) as? ForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let daysForecastArray = viewModel?.wetherModel?.daysForecast {
            let dayForecast = daysForecastArray[indexPath.item]
            cell.fillInfo(dayForecast: dayForecast)
        }
        return cell
    }
}

extension MainWetherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
