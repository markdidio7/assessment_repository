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
    
    private var imageCache: [String: UIImage] = [:] {
        didSet {
            // Set the image for row matching the new key added to the cache
            let key = Set(oldValue.keys).symmetricDifference(imageCache.keys).first
            let show = shows.enumerated().filter({ (_, show) in
                let imageKey = show.imageKey
                return imageKey == key
            }).first
            let path = (show?.offset).map { IndexPath(row: $0, section: 0) }
            
            DispatchQueue.main.async {
                let cell = path.map { self.tableView.cellForRow(at: $0) } as? ShowCell
                cell?.showImageView?.image = key.map { self.imageCache[$0] } as? UIImage
            }
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
        cell.showImageView.image = imageCache[show.imageKey ?? ""]
        return cell
    }
    
}

// MARK:- UITableViewDelegate

extension ShowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let show = shows[indexPath.row]
        let imageKey = show.imageKey ?? ""
        
        // Return if image already loaded
        guard imageCache[imageKey] == nil else { return }
        
        if let url = URL(string: imageKey.replacingOccurrences(of: "http", with: "https")) {
            URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
                guard error == nil, let data = data else { return }
                let image = UIImage(data: data)
                self.imageCache[imageKey] = image
            }.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ShowCell, let showDetailViewController = segue.destination as? ShowDetailViewController {
            if let indexPath = tableView.indexPath(for: cell) {
                showDetailViewController.initView(show: shows[indexPath.row], imageCache: self.imageCache)
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

