//
//  URLSession.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 24/10/21.
//

import Foundation

extension URLSession {
    
    func request<T: Codable>(url: URL?,
                             expecting: T.Type,
                             completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = dataTask(with: url) { data, response, error in
            
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(.failure(NetworkError.serviceError))
                return
            }
            
            if let error = error {
                completion(.failure(NetworkError.errorDescription(error: error)))
            }
            
            guard let jsonData = data else {
                completion(.failure(NetworkError.noDataAvailable))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: jsonData)
                completion(.success(result))
            } catch let anError {
                completion(.failure(NetworkError.errorDescription(error: anError)))
            }
        }
        task.resume()
    }
}
