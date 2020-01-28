//
//  ShowCell.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

class ShowCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var showImageView: UIImageView!
    @IBOutlet var scheduleLabel: UILabel!
    
    var show: Show!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showImageView.layer.cornerRadius = CornerRadius.small.rawValue
    }
    
    func initCell(show: Show) {
        self.show = show
        self.nameLabel.text = show.name
        self.scheduleLabel.text = show.schedule
    }
}
