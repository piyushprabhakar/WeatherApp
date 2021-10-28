//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 27/10/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}

