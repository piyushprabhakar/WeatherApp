//
//  DatabaseManager.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 20/10/21.
//

import UIKit
import Foundation
import CoreData

protocol DatabaseManagerProtocol {
    func storeSearchkeywords(latitude: Double?, longitude: Double?, cityName: String?)
    func fetchSearchHistory() -> [SearchedKeywordModel]
}

class DatabaseManager: NSObject, DatabaseManagerProtocol {
    
    func storeSearchkeywords(latitude: Double?, longitude: Double?, cityName: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        if let searchHistoryEntity = NSEntityDescription.entity(forEntityName: "SearchHistory", in: managedContext) {
            
            let aSearchRecord = NSManagedObject(entity: searchHistoryEntity, insertInto: managedContext)
            aSearchRecord.setValue(latitude ?? 0, forKey: "latitude")
            aSearchRecord.setValue(longitude ?? 0, forKey: "longitude")
            aSearchRecord.setValue(cityName ?? "", forKey: "searchKey")
            aSearchRecord.setValue(Date(), forKey: "searchDate")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func fetchSearchHistory() -> [SearchedKeywordModel] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchHistory")
        fetchRequest.fetchLimit = 15
        let sort = NSSortDescriptor(key: #keyPath(SearchHistory.searchDate), ascending: false)
            fetchRequest.sortDescriptors = [sort]
        
        var resultArray = [SearchedKeywordModel]()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let latitude = data.value(forKey: "latitude") as? Double
                let longitude = data.value(forKey: "longitude") as? Double
                let cityName = data.value(forKey: "searchKey") as? String
                let date = data.value(forKey: "searchDate") as? Date
                let dataModel = SearchedKeywordModel(latitude: latitude, longitude: longitude, cityName: cityName, date: date)
                resultArray.append(dataModel)
            }
            return resultArray
        } catch {
            print("Fetching data Failed")
            return resultArray
        }
        
    }
}


