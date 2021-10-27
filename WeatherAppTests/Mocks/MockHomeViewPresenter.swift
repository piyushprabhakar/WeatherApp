//
//  MockHomeViewPresenter.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherApp

class MockHomeViewPresenter {
    var getWeatherDataException: (expectation: XCTestExpectation?, location: CLLocation?, cityName: String?)
    var locationSearhResultExpectation: XCTestExpectation?
    var saveDataExpectation: (expectation: XCTestExpectation, location: CLLocation, cityName: String)?
    
}
extension MockHomeViewPresenter: HomeViewPresentable {
    func saveData(location: CLLocation?, cityName: String?) {
        saveDataExpectation?.expectation.fulfill()
    }
    
    var locationSearhResult: [LocationSearchResultModel] {
        locationSearhResultExpectation?.fulfill()
        locationSearhResultExpectation = nil
        return []
    }
    
    func getWeatherData(location: CLLocation?, cityName: String?) {
        guard cityName == getWeatherDataException.cityName else {return}
        getWeatherDataException.expectation?.fulfill()
    }
    
    
}
