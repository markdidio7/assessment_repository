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
    
    var cache: [String: UIImage] = [:]
    
    func downloadImage(urlString: String, dataTask: inout URLSessionDataTask?, completion: @escaping (UIImage?)->()) {
        if let chacedImage = cache[urlString] {
            completion(chacedImage)
        } else {
            if let url = URL(string: urlString.replacingOccurrences(of: "http:", with: "https:")) {
                dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    guard error == nil, let data = data else { return }
                    if let downloadedImage = UIImage(data: data) {
                        self.cache[urlString] = downloadedImage
                        completion(downloadedImage)
                    } else {
                        completion(nil)
                    }
                })
                dataTask?.resume()
            } else {
                completion(nil)
            }
        }
    }
}
