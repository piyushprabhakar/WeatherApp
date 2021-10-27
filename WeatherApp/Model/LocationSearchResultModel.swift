//
//  SearchResultModel.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 19/10/21.
//

import UIKit

struct LocationSearchResultModel: Codable {
    let title: String
    let locationType: String
    let locationId: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case locationType = "location_type"
        case locationId = "woeid"
    }
}


