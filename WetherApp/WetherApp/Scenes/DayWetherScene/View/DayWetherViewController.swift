//
//  DayWetherViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 18.08.21.
//

import UIKit

class DayWetherViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var hourlyForecastTableView: UITableView!
    @IBOutlet weak var detailedInfoTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var wetherContainerView: UIView!
    @IBOutlet weak var forecastTableViewContainer: UIView!

    @IBOutlet weak var trailingConstraintWetherContainer: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintWetherContainer: NSLayoutConstraint!

    var viewModel: DayWetherViewModel?
    var animationController: ViewAnimation?
    var tableController: DetailedInfoTableController?
    var hourlyForecastTableController: HourlyForecastTableController?
    var startLocationX: CGFloat = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViewControllerSettings()
        setupViewModel()
    }

    private func setupViewControllerSettings() {
        setupDetailedInfoTable()
        setupHourForecastTable()
        setupViewAnimationController()
        setupViewsSettings()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveContainerWetherView(sender:)))
        wetherContainerView.addGestureRecognizer(panGesture)
    }

    private func setupDetailedInfoTable() {
        tableController = DetailedInfoTableController()
        detailedInfoTableView.dataSource = tableController
        let nibName = String(describing: DetailedInfoTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        detailedInfoTableView.register(nib, forCellReuseIdentifier: DetailedInfoTableViewCell.identifier)
    }

    private func setupHourForecastTable() {
        hourlyForecastTableController = HourlyForecastTableController()
        hourlyForecastTableView.dataSource = hourlyForecastTableController
        let nibName = String(describing: HourForecastTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        hourlyForecastTableView.register(nib, forCellReuseIdentifier: HourForecastTableViewCell.identifier)
    }

    private func setupViewsSettings() {
        conditionView.layer.cornerRadius = 15
        wetherContainerView.layer.cornerRadius = 10
        forecastTableViewContainer.layer.cornerRadius = 10
    }

    private func setupViewAnimationController() {
        animationController = ViewAnimation(mainView: view,
                                            movingView: wetherContainerView,
                                            leftConstraint: leadingConstraintWetherContainer,
                                            rightConstraint: trailingConstraintWetherContainer)
        animationController?.delegate = self
    }

    private func setupViewModel() {
        viewModel = ViewModelsFactory.createDayWetherViewModel()
        viewModel?.didUpdateCurrentWetherInfoModel = { wetherModel in
            self.temperatureLabel.text = String(wetherModel.temperature)
            self.conditionLabel.text = wetherModel.condition
            self.tableController?.wetherModel = wetherModel
            self.hourlyForecastTableController?.wetherModel = wetherModel
            self.detailedInfoTableView.reloadData()
            self.hourlyForecastTableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        viewModel?.didUpdateCurrentWetherDecorModel = { wetherDecor in
            self.backgroundImageView.image = UIImage(named: wetherDecor.backgroundImageName)
            let conditionColorString = wetherDecor.conditionViewColor.rawValue
            self.conditionView.backgroundColor = UIColor.hexStringToUIColor(
                hex: conditionColorString)
            let collectionColorString = wetherDecor.collectionViewColor.rawValue
            self.wetherContainerView.backgroundColor = UIColor.hexStringToUIColor(hex: collectionColorString)
            self.forecastTableViewContainer.backgroundColor = UIColor.hexStringToUIColor(hex: collectionColorString)
        }
        viewModel?.didLoad()
    }

    @objc
    private func moveContainerWetherView(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            startLocationX = sender.location(in: view).x
        case .changed:
            leadingConstraintWetherContainer.constant += sender.translation(in: view).x
            trailingConstraintWetherContainer.constant -= sender.translation(in: view).x
            view.layoutIfNeeded()
            sender.setTranslation(.zero, in: view)
        case .ended:
            animationController?.makeViewAnimation(
                startLocation: startLocationX,
                lastLocation: sender.location(in: view).x)
        default:
            break
        }
    }
}

extension DayWetherViewController: ViewAnimationDelegate {
    func updateData() {
        tableController?.changeWetherInfoType()
        detailedInfoTableView.reloadData()
    }
}
