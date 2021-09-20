//
//  DayWetherViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 18.08.21.
//

import UIKit

class DayWetherViewController: UIViewController {

    @IBOutlet weak var trailingConstraintWetherContainer: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintWetherContainer: NSLayoutConstraint!
    @IBOutlet weak var hoursForecastTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionView: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var wetherContainerView: UIView!
    @IBOutlet weak var detailedInfoTableView: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var forecastTableViewContainer: UIView!
    var viewModel: DayWetherViewModel?

    var startLocationX: CGFloat = .zero
    var tableController: DetailedInfoTableController?
    var hourlyForecastTableController: HourlyForecastTableController?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViewControllerSettings()
        setupViewModel()
    }

    private func setupViewControllerSettings() {
        tableController = DetailedInfoTableController()
        hourlyForecastTableController = HourlyForecastTableController()
        detailedInfoTableView.dataSource = tableController
        // detailedInfoTableView.delegate = detailedInfoTableController
        hoursForecastTableView.dataSource = hourlyForecastTableController

        var nibName = String(describing: DetailedInfoTableViewCell.self)
        var nib = UINib(nibName: nibName, bundle: nil)
        detailedInfoTableView.register(nib, forCellReuseIdentifier: DetailedInfoTableViewCell.identifier)

        nibName = String(describing: HourForecastTableViewCell.self)
        nib = UINib(nibName: nibName, bundle: nil)
        hoursForecastTableView.register(nib, forCellReuseIdentifier: HourForecastTableViewCell.identifier)

        wetherContainerView.layer.cornerRadius = 10
        forecastTableViewContainer.layer.cornerRadius = 10
        conditionView.layer.cornerRadius = 15
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveContainerWetherView(sender:)))
        wetherContainerView.addGestureRecognizer(panGesture)
    }

    private func setupViewModel() {
        viewModel = ViewModelsFactory.createDayWetherViewModel()
        viewModel?.didUpdateCurrentWetherInfoModel = { wetherModel in
            self.temperatureLabel.text = String(wetherModel.temperature)
            self.conditionLabel.text = wetherModel.condition
            self.tableController?.wetherModel = wetherModel
            self.hourlyForecastTableController?.wetherModel = wetherModel
            self.detailedInfoTableView.reloadData()
            self.hoursForecastTableView.reloadData()
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
            // wetherContainerView.frame.origin.x += sender.translation(in: view).x
            leadingConstraintWetherContainer.constant += sender.translation(in: view).x
            trailingConstraintWetherContainer.constant -= sender.translation(in: view).x
            view.layoutIfNeeded()
            sender.setTranslation(.zero, in: view)
        case .ended:
            makeGalleryAnimation(senderLastLocationX: sender.location(in: view).x)
        default:
            break
        }
    }

    private func makeGalleryAnimation(senderLastLocationX: CGFloat) {
        if senderLastLocationX < startLocationX {
            if wetherContainerView.frame.minX < 0 {
                makeLeftSideAnimation()
            } else {
                makeNormaStateAnimation()
            }
        } else {
            if wetherContainerView.frame.maxX > view.frame.width {
                makeRightSideAnimation()
            } else {
                makeNormaStateAnimation()
            }
        }
    }

    private func makeLeftSideAnimation() {
        moveImageView(leftConstraint: -wetherContainerView.frame.width,
                      rightConstraint: view.frame.width,
                      view: wetherContainerView,
                      alpha: 0) { [weak self] _ in
            self?.tableController?.changeWetherInfoType()
            self?.detailedInfoTableView.reloadData()
            self?.wetherContainerView.frame.origin.x = self?.view.frame.maxX ?? 0
            self?.moveImageView(leftConstraint: 60,
                                rightConstraint: 60,
                                view: self?.wetherContainerView,
                                alpha: 1,
                                completion: nil)
        }
    }

    private func makeRightSideAnimation() {
        moveImageView(leftConstraint: view.frame.maxX,
                      rightConstraint: -wetherContainerView.frame.width,
                      view: wetherContainerView,
                      alpha: 0) { [weak self] _ in
            self?.tableController?.changeWetherInfoType()
            self?.detailedInfoTableView.reloadData()
            self?.wetherContainerView.frame.origin.x = -(self?.wetherContainerView.frame.width ?? 0)
            self?.moveImageView(leftConstraint: 60,
                                rightConstraint: 60,
                                view: self?.wetherContainerView,
                                alpha: 1,
                                completion: nil)
        }
    }

    private func makeNormaStateAnimation() {
        moveImageView(leftConstraint: 60, rightConstraint: 60, view: wetherContainerView, alpha: 1, completion: nil)
    }

    private func moveImageView(leftConstraint: CGFloat,
                               rightConstraint: CGFloat,
                               view: UIView?,
                               alpha: CGFloat,
                               completion: ((Bool) -> Void)?) {
        guard let view = view else { return }
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.leadingConstraintWetherContainer.constant = leftConstraint
            self.trailingConstraintWetherContainer.constant = rightConstraint
            view.alpha = alpha
            self.view.layoutIfNeeded()
        }, completion: completion)

    }
}
