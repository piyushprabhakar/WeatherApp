//
//  ViewController.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 18/10/21.
//

import UIKit
import MaterialActivityIndicator

protocol HomeViewViewable: AnyObject {
    var state: HomeViewController.LoadingState {get set}
    func showErrorMessage(message: NetworkError)
    func showResult()
}

class HomeViewController: UIViewController {
   
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var presentable: HomeViewPresentable?
    
    lazy var dataSource = HomeViewTableViewDataSource(delegate: self)
    
    private let activityIndicatorView = MaterialActivityIndicatorView()

    enum LoadingState {
        case loading, finished, empty, error
    }
    
    var state: LoadingState = .empty {
        didSet {
            switch state {
            case .loading:
                tableView?.isHidden = true
                statusLabel?.text = "Loading..."
                activityIndicatorView.startAnimating()
            case .finished:
                tableView?.isHidden = false
                statusLabel?.text = nil
                activityIndicatorView.stopAnimating()
            case .empty:
                tableView?.isHidden = true
                statusLabel?.text = "No result found"
                activityIndicatorView.stopAnimating()
            case .error:
                tableView?.isHidden = true
                statusLabel?.text = "Something went wrong"
                activityIndicatorView.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Weather info"
        
        presentable = HomeViewPresenter(viewable: self)
        
        setupActivityIndicatorView()
        setupSearchBar()
        setupTableView()
        
        getCurrentLocaationWeatherData(saveSerchedKeyword: false)
    }
    
    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
        dataSource.registerViews(tableView)
    }
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func getCurrentLocaationWeatherData(saveSerchedKeyword: Bool) {
        LocationManager.shared.getUserLocation { [weak self] location in
            self?.presentable?.getWeatherData(location: location, cityName: nil)
            if saveSerchedKeyword {
                self?.presentable?.saveData(location: location, cityName: nil)
            }
        } 
    }
    
    //MARK:- IB Action
    
    @IBAction func didTapLocation(_ sender: UIButton) {
        getCurrentLocaationWeatherData(saveSerchedKeyword: true)
    }
    @IBAction func showSearchHistory(_ sender: UIButton) {
        let searchResult = UIStoryboard.main.instantiateViewController(SearchHistoryViewController.self)
        self.navigationController?.pushViewController(searchResult, animated: true)
    }
}

//MARK:- Search Bar Delegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let cityName = searchBar.text {
            self.presentable?.getWeatherData(location: nil, cityName: cityName)
            self.presentable?.saveData(location: nil, cityName: cityName)
        }
        searchController.dismiss(animated: true, completion: nil)
        searchBar.resignFirstResponder()
    }
}

//MARK:- HomeViewTableViewDataSource Delegate

extension HomeViewController: HomeViewTableViewDataSourceDelegate {
    
    func homeViewTableViewDataSource(_ dataSource: HomeViewTableViewDataSource, deselectRowAt indexPath: IndexPath) {
        let weatherForcastVC = UIStoryboard.main.instantiateViewController(WeatherForcastViewController.self)
        weatherForcastVC.locationID = dataSource.locationSearchResult[indexPath.row].locationId
        self.navigationController?.pushViewController(weatherForcastVC, animated: true)
    }
}

//MARK:- HomeView prptocol

extension HomeViewController: HomeViewViewable {
    
    func showResult() {
        dataSource.locationSearchResult = presentable?.locationSearhResult ?? []
        self.tableView.reloadData()
    }
    
    func showErrorMessage(message: NetworkError) {
        let alert = UIAlertController(title: "Alert", message: message.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK:- Activity Indicator

private extension HomeViewController {
    func setupActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        setupActivityIndicatorViewConstraints()
    }

    func setupActivityIndicatorViewConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
