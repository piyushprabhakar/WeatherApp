//
//  HomePresentertestCase.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import XCTest
@testable import WeatherApp
import CoreLocation

class HomePresentertestCase: XCTestCase {
    var mockView: MockHomeViewController!
    let exceptionTimeout = 2.0
    var sut: HomeViewPresenter!
    var networkManager: MockNetworkManager!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockView = MockHomeViewController()
        sut = HomeViewPresenter(viewable: mockView)
        networkManager = MockNetworkManager()
        sut.service = networkManager
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockView = nil
        sut = nil
        networkManager = nil
    }

    
    func testGetWeatherDataForCityName(){
        sut.getWeatherData(islocationAvailable: false, cityName: "Delhi", saveSearchedKeyword: false)
        XCTAssertEqual(sut.locationSearhResult[0].title, "Delhi")
        XCTAssertEqual(sut.locationSearhResult[0].locationId, 2455920)
        XCTAssertEqual(sut.locationSearhResult[0].locationType, "City")
    }
    
    func testGetWeatherDataForCityNameReturnError(){
        networkManager.shouldReturnError = true
        sut.getWeatherData(islocationAvailable: false, cityName: "Delhi", saveSearchedKeyword: false)
        XCTAssertTrue(sut.locationSearhResult.isEmpty)
    }
    

}
