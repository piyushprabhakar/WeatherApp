//
//  SearchHistoryTableViewDataSource.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit

class SearchHistoryTableViewDataSource: NSObject {
    var searchHistoryData = [SearchedKeywordModel]()
}

extension SearchHistoryTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SearchHistoryTableViewCell.self, for: indexPath)
        cell.configureCell(dataSource: searchHistoryData[indexPath.row])
        return cell
    }
}

extension SearchHistoryTableViewDataSource {
    func registerViews(_ tableView: UITableView){
        tableView.register(SearchHistoryTableViewCell.self)
    }
}
