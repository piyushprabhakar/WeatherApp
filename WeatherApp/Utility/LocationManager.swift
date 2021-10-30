//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 19/10/21.
//

import UIKit
import CoreLocation

protocol LocationManagerProtocol {
    func getUserLocation(completion: @escaping ((CLLocation) -> Void))
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    
    var locationManager = CLLocationManager()
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
    }

    var completion: ((CLLocation) -> Void)?
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        locationManager.stopUpdatingLocation()
    }
    
    
}

extension LocationManager: LocationManagerProtocol {}
