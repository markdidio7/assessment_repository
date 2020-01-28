//
//  ShowsViewController.swift
//  Flix
//
//  Created by Mark Di Dio on 24/1/20.
//  Copyright © 2020 Mark Di Dio. All rights reserved.
//

import Foundation
import UIKit

class ShowsViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    // MARK:- Data
    
    private var shows: [Show] = [] {
        didSet {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    // MARK:- ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSearchBar()
        APICalls.get.loadAllShows { (shows) in
            self.shows = shows
        }
    }
    
}

// MARK:- UITableViewDataSource

extension ShowsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = shows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowCell
        cell.initCell(show: show)
        cell.showImageView.image = ImageCaching.get.imageCache[show.imageKey ?? ""]
        return cell
    }
    
}

// MARK:- UITableViewDelegate

extension ShowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let show = shows[indexPath.row]
        let imageKey = show.imageKey ?? ""
        
        // Return if image already loaded
        guard ImageCaching.get.imageCache[imageKey] == nil else { return }
        
        ImageCaching.get.downloadImage(urlString: imageKey) { (image) in
            ImageCaching.get.updateShowsListImage(shows: self.shows, imageKey: imageKey, tableView: tableView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ShowCell, let showDetailViewController = segue.destination as? ShowDetailViewController {
            if let indexPath = tableView.indexPath(for: cell) {
                showDetailViewController.initView(show: shows[indexPath.row])
            }
        }
    }
    
}

extension ShowsViewController {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shows.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text?.replacingOccurrences(of: " ", with: "+") {
            APICalls.get.searchURL(text: searchText) { (shows) in
                self.shows = shows
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        APICalls.get.loadAllShows { (shows) in
            self.shows = shows
        }
    }
}

