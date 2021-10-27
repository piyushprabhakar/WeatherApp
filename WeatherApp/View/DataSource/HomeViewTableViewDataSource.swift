//
//  HomeViewTableViewDataSource.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit

protocol HomeViewTableViewDataSourceDelegate: AnyObject {
    func homeViewTableViewDataSource(_ dataSource: HomeViewTableViewDataSource, deselectRowAt indexPath: IndexPath)
}

class HomeViewTableViewDataSource: NSObject {
    
    var locationSearchResult = [LocationSearchResultModel]()
    
    weak var delegate: HomeViewTableViewDataSourceDelegate?
    
    init(delegate: HomeViewTableViewDataSourceDelegate) {
        self.delegate = delegate
    }

}

extension HomeViewTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HomeTableViewCell.self, for: indexPath)
        cell.configureCell(dataSource: locationSearchResult[indexPath.row])
        return cell
    }
}

extension HomeViewTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.homeViewTableViewDataSource(self, deselectRowAt: indexPath)
    }
}

extension HomeViewTableViewDataSource {
    
    func registerViews(_ tableView: UITableView){
        tableView.register(HomeTableViewCell.self)
    }
}
