//
//  WeatherForcastPresenter.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 20/10/21.
//

import UIKit

protocol WeatherForcastPresentable {
    var everyDayWeatherData: [EverydayWeatherModel] {get}
    func getWeatherForcastData(locationId: Int)
}

class WeatherForcastPresenter: NSObject {

    weak var viewable: WeatherForcastViewable?
    var service = NetworkManager()
    
    var everyDayWeatherData: [EverydayWeatherModel] = [] {
        didSet {
            guard !everyDayWeatherData.isEmpty else {
                //viewable.state = .noResult
                return
            }
            viewable?.showResult()
        }
    }
    
    init(viewable: WeatherForcastViewable) {
        self.viewable = viewable
    }
}

extension WeatherForcastPresenter: WeatherForcastPresentable  {
    func getWeatherForcastData(locationId: Int) {
        service.getWeatherPredection(locationID: locationId) { [weak self] result in
            switch result {
            case .success(let dataModel):
                self?.everyDayWeatherData = dataModel.consolidatedWeatherReport
            case .failure(let error):
                self?.viewable?.showErrorMessage(message: error.localizedDescription)
            }
        }
    }
}
