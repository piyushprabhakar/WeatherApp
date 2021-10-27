//
//  MockHomeViewController.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation
@testable import WeatherApp
import XCTest

class MockHomeViewController {
    var showErrorMessageExpectation: XCTestExpectation?
    var showResultExpectation: XCTestExpectation?
    var getStateException: XCTestExpectation?
    var setStateException: (expectation: XCTestExpectation, newvalue: HomeViewController.LoadingState)?

}

extension MockHomeViewController: HomeViewViewable {
    
    var state: HomeViewController.LoadingState {
        get {
            getStateException?.fulfill()
            return .empty
        }
        set(newValue) {
            guard newValue == setStateException?.newvalue else {return}
            setStateException?.expectation.fulfill()
        }
    }
    
   
    func showErrorMessage(message: NetworkError) {
        showErrorMessageExpectation?.fulfill()
    }
    
    func showResult() {
        showResultExpectation?.fulfill()
    }
    
    
   
}
