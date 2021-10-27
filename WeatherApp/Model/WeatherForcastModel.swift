//
//  WeatherForcastModel.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation

struct WeatherForcastModel: Codable {
    var consolidatedWeatherReport: [EverydayWeatherModel]
    var title: String
    var locationType: String
    var timezone: String
    enum CodingKeys: String, CodingKey {
        case title, timezone
        case locationType = "location_type"
        case consolidatedWeatherReport = "consolidated_weather"
    }
}

struct EverydayWeatherModel: Codable {
    let id: Int?
    let weatherStateName: String? //weather_state_name
    let weatherStateAbbr: String? //weather_state_abbr
    let windDirectionCompass: String? //wind_direction_compass
    let created: String?
    let applicableDate: String? //applicable_date
    let minTemp: Float? //min_temp
    let maxTemp: Float? //max_temp
    let theTemp: Float? //the_temp
    let windSpeed: Float? //wind_speed
    let windDirection: Float? //wind_direction
    let airPressure: Float? //air_pressure
    let humidity: Int?
    let visibility: Float?
    let predictability: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, humidity, visibility, predictability,created
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
    }
}
