//
//  MockHomeViewTableViewDataSourceDelegate.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import XCTest
import Foundation
@testable import WeatherApp

class MockHomeViewTableViewDataSourceDelegate: HomeViewTableViewDataSourceDelegate {
    
   
    var homeViewTableViewDataSourceDeselectRowExpectation: (expectation: XCTestExpectation, dataSource: HomeViewTableViewDataSource, indexPath: IndexPath)?
    
    func homeViewTableViewDataSource(_ dataSource: HomeViewTableViewDataSource, deselectRowAt indexPath: IndexPath) {
        if homeViewTableViewDataSourceDeselectRowExpectation?.dataSource == dataSource &&  homeViewTableViewDataSourceDeselectRowExpectation?.indexPath == indexPath {
            homeViewTableViewDataSourceDeselectRowExpectation?.expectation.fulfill()
        }
    }
    

    
}
