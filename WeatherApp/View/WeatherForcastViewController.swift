//
//  WeatherForcastViewController.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 20/10/21.
//

import UIKit

protocol WeatherForcastViewable: AnyObject {
    func showErrorMessage(message: String)
    func showResult()
}

class WeatherForcastViewController: UIViewController, Storyboarded {
    

    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?

    var dataSource: WeatherForcastTableViewDataSource?
    var locationID: Int = 0
    var presentable: WeatherForcastPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Weather Forcast"
        
        setupTableView()
        
        presentable = WeatherForcastPresenter(viewable: self)
        presentable?.getWeatherForcastData(locationId: locationID)
    }
    
    private func setupTableView(){
        dataSource = WeatherForcastTableViewDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
        dataSource?.registerViews(tableView)
    }
    
}

extension WeatherForcastViewController: WeatherForcastViewable {
    
    func showErrorMessage(message: String) {
    }
    
    func showResult() {
        dataSource?.everyDayWeatherData = presentable?.everyDayWeatherData ?? []
        self.tableView.reloadData()
    }
}
