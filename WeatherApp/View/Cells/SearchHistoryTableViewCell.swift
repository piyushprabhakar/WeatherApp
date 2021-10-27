//
//  SearchHistoryTableViewCell.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet var searchedKeywordLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func configureCell(dataSource: SearchedKeywordModel) {
        searchedKeywordLabel.text = dataSource.searchedKeyword
        dateLabel.text = dataSource.displayedDate
    }
}
