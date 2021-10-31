//
//  SearchResultPresenter.swift
//  WeatherApp
//
//  Created by Piyush Prabhakar on 23/10/21.
//

import UIKit

protocol SearchHistoryPresentable {
    var searchResultData: [SearchedKeywordModel] {get}
    func fetchSearchHistory()
}

class SearchResultPresenter: NSObject {
    
    weak var viewable: SearchHistoryViewable?
    let dataBaseManagerObject: DatabaseManagerProtocol = DatabaseManager()
    
    var searchResultData: [SearchedKeywordModel] = [] {
        didSet {
            guard !searchResultData.isEmpty else {
                //viewable.state = .noResult
                return
            }
            viewable?.showResult()
        }
    }
    
    init(viewable: SearchHistoryViewable) {
        self.viewable = viewable
    }
}

extension SearchResultPresenter: SearchHistoryPresentable {
    func fetchSearchHistory() {
        searchResultData = dataBaseManagerObject.fetchSearchHistory()
    }

}
