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
    var getWeatherDataException: (expectation: XCTestExpectation?, location: CLLocation?, cityName: String?, saveSearchedKeyword: Bool)?
    var locationSearhResultExpectation: XCTestExpectation?
    
}
extension MockHomeViewPresenter: HomeViewPresentable {
    
    var locationSearhResult: [LocationSearchResultModel] {
        locationSearhResultExpectation?.fulfill()
        locationSearhResultExpectation = nil
        return []
    }
    
    func getWeatherData(islocationAvailable: Bool, cityName: String?, saveSearchedKeyword: Bool) {
        guard cityName == getWeatherDataException?.cityName else {return}
        getWeatherDataException?.expectation?.fulfill()
    }
}
