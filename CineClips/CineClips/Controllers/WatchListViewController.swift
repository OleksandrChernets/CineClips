//
//  FavouriteViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 15.01.2023.
//

import UIKit

class WatchListViewController: UIViewController {
    
    var savedMovies: [MovieRealm] = []
    var viewModel: WatchListViewModel = WatchListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "WATCH LIST"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedMovies = viewModel.getMovie()
        
        self.tableView.reloadData()
    }
    
}


extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchListTableViewCell", for: indexPath) as? WatchListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureWith(movie: savedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        303
        
    }
    
    
}
