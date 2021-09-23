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
    }

    private func setupViewModelSettings() {
        viewModel = ViewModelsFactory.createMainWetherViewModel()
        viewModel?.didUpdateCurrentWetherInfoModel = { wetherModel in
            self.temperatureLabel.text = String(wetherModel.temperature)
            self.conditionLabel.text = wetherModel.condition
            self.collectionView.reloadData()
            self.cityButton.setTitle(wetherModel.location, for: .normal)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        viewModel?.didUpdateCurrentWetherDecorModel = { wetherDecor in
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

    @objc
    func temperatureLabelTap(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DayWetherViewController")
        present(controller, animated: true, completion: nil)
    }
}

extension MainWetherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.currentWether?.daysForecast.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier,
            for: indexPath) as? ForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let daysForecastArray = viewModel?.currentWether?.daysForecast {
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
