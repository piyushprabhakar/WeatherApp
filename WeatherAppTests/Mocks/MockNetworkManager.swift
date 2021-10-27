//
//  MockNetworkManager.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation

@testable import WeatherApp


class MockNetworkManager {
    
    var shouldReturnError = false
    var getlocationWasCalled = false
    var getWeatherPredectionWasCalled = false
    
    func reset() {
        shouldReturnError = false
        getlocationWasCalled = false
        getWeatherPredectionWasCalled = false
    }
    


    convenience init(){
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let locationSearchResult: [LocationSearchResultModel] = [LocationSearchResultModel(title: "Delhi", locationType: "City", locationId: 2455920), LocationSearchResultModel(title: "Santa Cruz", locationType: "City", locationId: 2463583)]

    let weatherForcastModel = WeatherForcastModel(consolidatedWeatherReport:
                                                    [EverydayWeatherModel(id: 5512270558789632, weatherStateName: "Clear", weatherStateAbbr: "c", windDirectionCompass: "NE", created: "2021-10-24T04:31:41.361902Z", applicableDate: "2021-10-24", minTemp: 12.82, maxTemp: 20.415, theTemp: 20.155, windSpeed: 3.4295067189161963, windDirection: 54.71240508406253, airPressure: 1023.0, humidity: 56, visibility: 13.79071224051539, predictability: 68)],
                                                  title: "",
                                                  locationType: "",
                                                  timezone: "")
}

extension MockNetworkManager: NetworkManagerProtocol {
    
    
    func getLocationDetails(lat: Double?, long: Double?, cityName: String?, completionHandler: @escaping (Result<[LocationSearchResultModel], NetworkError>) -> Void) {
        getlocationWasCalled = true
        
        if shouldReturnError {
            completionHandler(.failure(.serviceError))
        }else{
            completionHandler(.success(locationSearchResult))
        }
    }
    
    func getWeatherPredection(locationID: Int, completionHandler: @escaping (Result<WeatherForcastModel, NetworkError>) -> Void) {
        if shouldReturnError {
            completionHandler(.failure(.serviceError))
        }else{
            completionHandler(.success(weatherForcastModel))
        }
    }
    
    
}
