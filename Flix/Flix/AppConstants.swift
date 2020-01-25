//
//  AppConstants.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

class AppConstants {
    
    static var baseURL = "https://api.tvmaze.com/"
    static var allShowsURL = "shows"
    static var searchShowsURL = "search/shows?q="
    
}

enum CornerRadius: CGFloat {
    case small = 8
    case medium = 16
    case large = 32
}
