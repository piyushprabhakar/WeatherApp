//
//  HomeViewPresenter.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 20/10/21.
//

import Foundation
import CoreLocation

protocol HomeViewPresentable {
    var locationSearhResult: [LocationSearchResultModel] {get}
    func getWeatherData(islocationAvailable: Bool, cityName: String?, saveSearchedKeyword: Bool)
}

class HomeViewPresenter: NSObject {
    
    weak var viewable: HomeViewViewable?
    var service: NetworkManagerProtocol = NetworkManager()
    var databaseManager: DatabaseManagerProtocol = DatabaseManager()
    lazy var locationManager: LocationManagerProtocol = LocationManager(locationManager: CLLocationManager())
    
    init(viewable: HomeViewViewable) {
        self.viewable = viewable
    }
    
    var locationSearhResult: [LocationSearchResultModel] = [] {
        didSet {
            guard !locationSearhResult.isEmpty else {
                self.viewable?.state = .empty
                return
            }
            viewable?.showResult()
        }
        
    }
    
    private func saveData(location: CLLocation?, cityName: String?, saveSerchedKeyword: Bool) {
        if saveSerchedKeyword {
            databaseManager.storeSearchkeywords(latitude: location?.coordinate.latitude, longitude: location?.coordinate.longitude, cityName: cityName)
        }
    }
    
    
    private func getWeatherData(location: CLLocation?, cityName: String?) {
        self.viewable?.state = .loading
        service.getLocationDetails(lat: location?.coordinate.latitude, long: location?.coordinate.longitude, cityName: cityName) { [weak self] result in
            switch result {
            case .success(let dataModel):
                if dataModel.isEmpty{
                    self?.locationSearhResult = dataModel
                    self?.viewable?.state = .empty
                } else {
                    self?.locationSearhResult = dataModel
                    self?.viewable?.state = .finished
                }
            case .failure(let error):
                self?.viewable?.state = .error
                self?.viewable?.showErrorMessage(message: .errorDescription(error: error))
            }
        }
    }
}


extension HomeViewPresenter: HomeViewPresentable {
    
    func getWeatherData(islocationAvailable: Bool, cityName: String?, saveSearchedKeyword: Bool) {
        var userLocation: CLLocation?
        if islocationAvailable {
            locationManager.getUserLocation { location in
                userLocation = location
                self.getWeatherData(location: location, cityName: cityName)
                self.saveData(location: userLocation, cityName: cityName, saveSerchedKeyword: saveSearchedKeyword)
                
            }
        } else {
            self.getWeatherData(location: userLocation, cityName: cityName)
            saveData(location: userLocation, cityName: cityName, saveSerchedKeyword: saveSearchedKeyword)
            
        }
        
    }
}

