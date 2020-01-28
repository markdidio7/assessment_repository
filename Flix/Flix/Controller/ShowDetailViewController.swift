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
    
    var show: Show?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImageView.layer.cornerRadius = CornerRadius.small.rawValue
        updateInfo()
    }
    
    func initView(show: Show) {
        self.show = show
    }
    
    func updateInfo() {
        if let show = self.show {
            titleLabel.text = show.name
            yearLabel.text = show.premiered
            timeslotLabel.text = show.schedule
            genresLabel.text = show.genres
            summaryLabel.text = show.summary
            if let rating = show.averageRating {
                ratingLabel.text = String(format: "Average Rating: %.1f", rating)
            } else {
                ratingLabel.text = "No Rating"
            }
            ImageCaching.get.downloadImage(urlString: show.imageKey ?? "") { (image) in
                DispatchQueue.main.async {
                    self.showImageView.image = image
                    self.backingShowImageView.image = image
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ImageCaching.get.cancelRunningDataTask()
    }
}

