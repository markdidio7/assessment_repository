//
//  ShowDetailViewController.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

class ShowDetailViewController: UIViewController {
    
 @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backingShowImageView: UIImageView!
    @IBOutlet var showImageView: UIImageView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var timeslotLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    var show: Show!
    private var imageCache: [String: UIImage] = [:]
    var urlTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setCustomNavigationBar(barStyle: .black, tintColor: .white, shadowImage: UIImage())
        showImageView.layer.cornerRadius = CornerRadius.small.rawValue
        updateInfo()
    }
    
    func initView(show: Show, imageCache: [String: UIImage]) {
        self.show = show
        self.imageCache = imageCache
    }
    
    func updateInfo() {
        titleLabel.text = show.name
        loadImage()
        yearLabel.text = show.premiered
        timeslotLabel.text = show.schedule
        genresLabel.text = show.genres
        summaryLabel.text = show.summary
        if let rating = show.averageRating {
            ratingLabel.text = String(format: "Average Rating: %.1f", rating)
        } else {
            ratingLabel.text = "No Rating"
        }
    }
    
    func loadImage() {
        let imageKey = show.imageKey ?? ""
        
        // Return if image already loaded
        guard imageCache[imageKey] == nil else {
            self.showImageView.image = imageCache[imageKey]
            self.backingShowImageView.image = imageCache[imageKey]
            return
        }
        
        if let url = URL(string: imageKey.replacingOccurrences(of: "http", with: "https")) {
            urlTask = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
                guard error == nil, let data = data else { return }
                let image = UIImage(data: data)
                self.imageCache[imageKey] = image
                DispatchQueue.main.async {
                    self.showImageView.image = image
                    self.backingShowImageView.image = image
                }
            }
            urlTask?.resume()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let task = urlTask {
            task.cancel()
        }
    }
}

