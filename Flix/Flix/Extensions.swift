//
//  Extensions.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}
