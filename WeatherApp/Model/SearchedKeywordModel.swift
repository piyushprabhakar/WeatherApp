//
//  SearchedKeywordModel.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation

struct SearchedKeywordModel {
    
    let latitude: Double?
    let longitude: Double?
    let cityName: String?
    let date: Date?
    
    var displayedDate: String? {
        return date?.dateAndTimetoString()
    }
    var searchedKeyword: String {
        guard let city = cityName, !city.isEmpty else {
            if let latitude = latitude, let longitude = longitude {
                return "(\(latitude), \(longitude))"
            }
            return ""
        }
        return city
    }
}
