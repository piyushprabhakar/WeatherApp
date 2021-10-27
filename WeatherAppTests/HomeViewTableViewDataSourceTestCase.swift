//
//  HomeViewTableViewDataSourceTestCase.swift
//  WeatherAppTests
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import XCTest
@testable import WeatherApp

class HomeViewTableViewDataSourceTestCase: XCTestCase {
    
    var sut: HomeViewTableViewDataSource! = nil
    
    var mockTableView: UITableView!
    
    var mockDelegate = MockHomeViewTableViewDataSourceDelegate()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockTableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
       
        sut = HomeViewTableViewDataSource(delegate: mockDelegate)
        sut.registerViews(mockTableView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDidSelect(){
        let indexPath = IndexPath(row: 0, section: 0)
        mockDelegate.homeViewTableViewDataSourceDeselectRowExpectation = (expectation(description: "expected did row to be called"), sut, indexPath)
        sut.tableView(mockTableView, didSelectRowAt: indexPath)
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }
    
    func testNumberOfRowReturnCorrectValue() {
        let locationSearchResult: [LocationSearchResultModel] = [LocationSearchResultModel(title: "Delhi", locationType: "City", locationId: 2455920), LocationSearchResultModel(title: "Santa Cruz", locationType: "City", locationId: 2463583)]
        sut.locationSearchResult = locationSearchResult
        let numberOfRow = sut.tableView(mockTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRow, 2)

    }

    func testCellForRowAtIndexPathCreatesTheCorrectCell() {
        let locationSearchResult: [LocationSearchResultModel] = [LocationSearchResultModel(title: "Delhi", locationType: "City", locationId: 2455920), LocationSearchResultModel(title: "Santa Cruz", locationType: "City", locationId: 2463583)]
        sut.locationSearchResult = locationSearchResult
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(mockTableView, cellForRowAt: indexPath)
        XCTAssertTrue(cell is HomeTableViewCell)
    }
    
    func testCellForRowAtIndexPath(){
        let locationSearchResult: [LocationSearchResultModel] = [LocationSearchResultModel(title: "Delhi", locationType: "City", locationId: 2455920), LocationSearchResultModel(title: "Santa Cruz", locationType: "City", locationId: 2463583)]
        sut.locationSearchResult = locationSearchResult
        
        let firstIndexPath = IndexPath(row: 0, section: 0)
        let firstCell = sut.tableView(mockTableView, cellForRowAt: firstIndexPath) as! HomeTableViewCell
        XCTAssertTrue(firstCell.titleLabel.text == "Title: Delhi")
        XCTAssertTrue(firstCell.locationId.text == "Location Id: 2455920")
        XCTAssertTrue(firstCell.locationTypeLabel.text == "Location Type: City")
        
        let secondIndexPath = IndexPath(row: 1, section: 0)
        let secondCell = sut.tableView(mockTableView, cellForRowAt: secondIndexPath) as! HomeTableViewCell
        XCTAssertTrue(secondCell.titleLabel.text == "Title: Santa Cruz")
        XCTAssertTrue(secondCell.locationId.text == "Location Id: 2463583")
        XCTAssertTrue(secondCell.locationTypeLabel.text == "Location Type: City")
    }
}
