//
//  DataStore.swift
//
//  Created by Jhanvi on 24/07/18.
//  Copyright © 2018 Jhanvi. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var articles: [Article] = []
    
    func getPopularArticles(completion: @escaping () -> Void) {
        //Populate the Article object from the received data
        
        APIClient.getPopularArticles { (json) in
            if let results = json?["results"] as? [ArticleData] {
                for dict in results {
                    let articleList = try? Article(dictionary: dict)
                    guard let data = articleList
                    else {
                        return
                    }
                    self.articles.append(data)
                }
                OperationQueue.main.addOperation {
                    completion()
                }
            }
        }
    }
}
