//
//  WeatherForcastTableViewDataSource.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit


class WeatherForcastTableViewDataSource: NSObject {
    
    var everyDayWeatherData = [EverydayWeatherModel]()
}

extension WeatherForcastTableViewDataSource: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return everyDayWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(WeatherForcastTableViewCell.self, for: indexPath)
        cell.configureCell(forcastData: everyDayWeatherData[indexPath.row])
        return cell
    }
    
}

extension WeatherForcastTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WeatherForcastTableViewDataSource {
    func registerViews(_ tableView: UITableView){
        tableView.register(WeatherForcastTableViewCell.self)
    }
}
