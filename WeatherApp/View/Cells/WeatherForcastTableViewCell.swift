//
//  WeatherForcastTableViewCell.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 20/10/21.
//

import UIKit

class WeatherForcastTableViewCell: UITableViewCell {

    @IBOutlet var weatherStateLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var applicableDateLabel: UILabel!
    
    func configureCell(forcastData: EverydayWeatherModel) {
        weatherStateLabel.text = "Weather state: \(forcastData.weatherStateName ?? "")"
        temperatureLabel.text = "Temperature: \(String(forcastData.theTemp ?? 0.0))"
        humidityLabel.text = "Humidity: \(String(forcastData.humidity ?? 0))"
        applicableDateLabel.text = "Date: \(forcastData.applicableDate ?? "")"
    }
}
