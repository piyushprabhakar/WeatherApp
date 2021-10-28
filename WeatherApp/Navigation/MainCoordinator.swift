//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 28/10/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showWeatherForcast(locationId: Int) {
        let viewController = WeatherForcastViewController.instantiate()
        viewController.locationID = locationId
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSearchHistory() {
        let viewController = SearchHistoryViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
