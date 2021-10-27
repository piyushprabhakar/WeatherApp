//
//  SearchHistoryViewController.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 21/10/21.
//

import UIKit

protocol SearchHistoryViewable: AnyObject {
    func showResult()
}

class SearchHistoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var dataSource: SearchHistoryTableViewDataSource?
    
    var presentable: SearchHistoryPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search History"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
       
        setupTableView()
        
        presentable = SearchResultPresenter(viewable: self)
        presentable?.fetchSearchHistory()
        
    }
    
    private func setupTableView() {
        dataSource = SearchHistoryTableViewDataSource()
        tableView.dataSource = dataSource
        dataSource?.registerViews(tableView)
    }
    
    
}

extension SearchHistoryViewController: SearchHistoryViewable {
   
    func showResult() {
        dataSource?.searchHistoryData = presentable?.searchResultData ?? []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
  
}
