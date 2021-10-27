//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 18/10/21.
//

import UIKit

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case serviceError
    case noDataAvailable
    case errorDescription(error: Error)
}

protocol NetworkManagerProtocol: AnyObject {
    
    func getLocationDetails(lat:Double?, long: Double?, cityName: String?, completionHandler: @escaping (Result<[LocationSearchResultModel], NetworkError>)-> Void)
    
    func getWeatherPredection(locationID: Int, completionHandler: @escaping (Result<WeatherForcastModel, NetworkError>)-> Void)
}


class NetworkManager: NSObject, NetworkManagerProtocol {

    func getLocationDetails(lat:Double?, long: Double?, cityName: String?, completionHandler: @escaping (Result<[LocationSearchResultModel], NetworkError>)-> Void) {
       
        var urlString = Constant.baseURL
        if let latitude = lat, let longitude = long {
            urlString = urlString.appending("search/?lattlong=\(latitude),\(longitude)")
        }
        if let cityName = cityName {
            urlString = urlString.appending("search/?query=\(cityName)")

        }
        guard let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let request = URL(string: urlEncodedString) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
       
        URLSession.shared.request(url: request, expecting: [LocationSearchResultModel].self) { result in
            switch result {
            case .success(let dataSource):
                DispatchQueue.main.async {
                    completionHandler(.success(dataSource))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func getWeatherPredection(locationID: Int, completionHandler: @escaping (Result<WeatherForcastModel, NetworkError>)-> Void) {
        
        let urlString = Constant.baseURL.appending(String(locationID))

        guard let request = URL(string: urlString) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.request(url: request, expecting: WeatherForcastModel.self) { result in
            switch result {
            case .success(let dataSource):
                DispatchQueue.main.async {
                    completionHandler(.success(dataSource))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}

