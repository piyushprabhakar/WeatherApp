//
//  SearchHistory+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 21/10/21.
//
//

import Foundation
import CoreData


extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var searchDate: Date?
    @NSManaged public var searchKey: String?

}

extension SearchHistory : Identifiable {

}
