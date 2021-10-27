//
//  Extension.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//
import Foundation

extension Date {
    func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

