//
//  HomeTableViewCell.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 19/10/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationTypeLabel: UILabel!
    @IBOutlet var locationId: UILabel!
    
    func configureCell(dataSource: LocationSearchResultModel) {
        titleLabel.text = "Title: \(dataSource.title)"
        locationTypeLabel.text = "Location Type: \(dataSource.locationType)"
        locationId.text = "Location Id: \(String(dataSource.locationId))"
    }

}
