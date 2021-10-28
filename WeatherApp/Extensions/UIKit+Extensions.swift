//
//  UIKit+Extensions.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        let name = String(describing: cellType)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("\(T.self) is expected to have reusable identifier: \(String(describing: cellType))")
        }
        
        return cell
    }
}


/*
 extension UIStoryboard {
     static let main = UIStoryboard(name: "Main", bundle: nil)
     
     func instantiateViewController<T: UIViewController>(_ viewControllerType: T.Type) -> T {
         guard let viewController = instantiateViewController(withIdentifier: String(describing: viewControllerType.self)) as? T else {
             fatalError("Unexpected view controller type for \(String(describing: viewControllerType.self))")
         }
         
         return viewController
     }
 }
 */
