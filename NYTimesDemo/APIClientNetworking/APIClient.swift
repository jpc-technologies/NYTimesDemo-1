//
//  APIClient.swift
//
//  Created by Jhanvi on 24/07/18.
//  Copyright © 2018 Jhanvi. All rights reserved.
//

import Foundation

typealias ArticleData = [String: Any]

struct APIClient {
    
    static func getPopularArticles(completion: @escaping (ArticleData?) -> Void) {
        
        //URL components
        let apikey = "af5c50d2ae89471f9a9cda8f0263ee19"
        let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(apikey)")
        
        //Make an api call
        let session = URLSession.shared
        
        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
        
        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            
            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? ArticleData
                completion(responseJSON)
            } catch {
                print("Could not get API data. \(error), \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}

