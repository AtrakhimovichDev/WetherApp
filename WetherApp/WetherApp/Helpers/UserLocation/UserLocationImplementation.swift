//
//  UserLocation.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 23.09.21.
//

import Foundation
import CoreLocation

class UserLocationImplementation: NSObject, UserLocation {

    let locationManager = CLLocationManager()
    weak var delegate: UserLocationDelegate?

    var city: String? {
        didSet {
            if let city = city {
                delegate?.didLocationUpdate(location: city)
            }
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func sendLocationRequest(location: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            LocationAPIManager.getLocationData(location: location) { [weak self] city in
                self?.city = city
            }
        }
    }
}

extension UserLocationImplementation: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            sendLocationRequest(location: "\(latitude),\(longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.requestLocation()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            break
        }
    }
}
