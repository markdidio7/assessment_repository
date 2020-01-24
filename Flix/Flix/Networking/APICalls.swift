//
//  APICalls.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation

class APICalls {
    
    static var get: APICalls = APICalls()
    
    func loadAllShows(completion: @escaping ([Show])->()) {
        let fullURL = AppConstants.baseURL + AppConstants.allShowsURL
        loadShows(from: fullURL, completion: completion)
    }
    
    func searchURL(text searchText: String, completion: @escaping ([Show])->()) {
        let fullURL = AppConstants.baseURL + AppConstants.searchShowsURL + searchText
        loadShows(from: fullURL, completion: completion)
    }
    
    private func loadShows(from urlString: String, completion: @escaping ([Show])->()) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data),
                    let jsonArray = json as? [[String: AnyObject]] else { return }
                
                let shows = jsonArray.map { (jsonShow) -> Show in
                    if let innerJsonShow = jsonShow["show"] as? [String: AnyObject] {
                        return Show(json: innerJsonShow)
                    } else {
                        return Show(json: jsonShow)
                    }
                }
                completion(shows)
            }.resume()
        }
    }
    
}
