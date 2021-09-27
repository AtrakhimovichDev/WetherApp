//
//  CitySearchViewController.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 27.09.21.
//

import UIKit

class CityViewController: UIViewController {

    var viewModel: CityViewModel?

    var city: String? {
        didSet {
            if let city = city {
                print(city)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didUpdateLocation, object: self, userInfo: ["City": city])
                    self.navigationController?.popViewController(animated: false)
                }
            }
        }
    }

    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel?.didLoad()

        searchController.delegate = self
        tableView.dataSource = self
        tableView.delegate = self

        let nibName = String(describing: CityTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CityTableViewCell.identifier)

        title = "Find your city"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupViewModel() {
        viewModel = ViewModelsFactory.createCityViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension CityViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.size.height / 2)
        view.addSubview(tableView)
        tableView.reloadData()
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        tableView.removeFromSuperview()
    }
}

extension CityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        viewModel?.filterCities(searchText: searchText)
        tableView.reloadData()
    }
}

extension CityViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel?.getFilteredCitiesCount() ?? 0
       }
        return viewModel?.getCitiesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var city: String
        var country: String

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell,
              let cityModel = viewModel?.cityModel else {
            return UITableViewCell()
        }
        if isFiltering {
            city = cityModel.filteredCities[indexPath.row].city
            country = cityModel.filteredCities[indexPath.row].country
        } else {
            city = cityModel.cities[indexPath.row].city
            country = cityModel.cities[indexPath.row].country
        }
        cell.textLabel?.text = city
        cell.detailTextLabel?.text = country
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var city = ""
        if isFiltering {
            city = viewModel?.cityModel?.filteredCities[indexPath.row].city ?? ""
        } else {
            city = viewModel?.cityModel?.cities[indexPath.row].city ?? ""
        }
        self.city = city
    }
}
