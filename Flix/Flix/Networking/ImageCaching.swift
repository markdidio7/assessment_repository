//
//  ImageCaching.swift
//  Flix
//
//  Created by Mark Di Dio on 27/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

class ImageCaching {
    
    static var get: ImageCaching = ImageCaching()
    
    var imageCache: [String: UIImage] = [:]
    var dataTask: URLSessionDataTask?
    
    func downloadImage(urlString: String, completion: @escaping (UIImage?)->()) {
        if let chacedImage = imageCache[urlString] {
            completion(chacedImage)
        } else {
            if let url = URL(string: urlString.replacingOccurrences(of: "http:", with: "https:")) {
                self.dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    guard error == nil, let data = data else { return }
                    if let downloadedImage = UIImage(data: data) {
                        self.imageCache[urlString] = downloadedImage
                        completion(downloadedImage)
                    } else {
                        completion(nil)
                    }
                })
                self.dataTask?.resume()
            } else {
                completion(nil)
            }
        }
    }
    
    func cancelRunningDataTask() {
        if let dataTask = self.dataTask {
            dataTask.cancel()
        }
    }
    
    func updateShowsListImage(shows: [Show], imageKey: String?, tableView: UITableView) {
        // Set the image for row matching the new key added to the cache
        let show = shows.enumerated().filter({ (_, show) in
            return imageKey == show.imageKey
        }).first
        let path = (show?.offset).map { IndexPath(row: $0, section: 0) }
        
        DispatchQueue.main.async {
            let cell = path.map { tableView.cellForRow(at: $0) } as? ShowCell
            cell?.showImageView?.image = imageKey.map { self.imageCache[$0] } as? UIImage
        }
    }
}
