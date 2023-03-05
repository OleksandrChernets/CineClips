//
//  FavouriteViewController.swift
//  CineClips
//
//  Created by Alexandr Chernets on 15.01.2023.
//

import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: Properties
    
    var movies: [Movie] = []
    var savedMovies: [MovieRealm] = []
    var viewModel: WatchListViewModel = WatchListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle Methods
    
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

// MARK: UITableViewDelegate & UITableViewDataSource

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovies.isEmpty ? 0 : savedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as? WatchListTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configureWith(movie: savedMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movieToDelete = savedMovies[indexPath.row]
            viewModel.deleteMovie(movie: movieToDelete)
            savedMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = savedMovies[indexPath.row]
        tableViewCellDelegate(movie: item)
    }
    
}

// MARK: WatchListTableViewCellDelegate

extension WatchListViewController: WatchListTableViewCellDelegate {
    func tableViewCellDelegate(movie: MovieRealm) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        let movie = Movie(
            id: movie.id,
            original_name: movie.originalTitle,
            original_title: movie.originalTitle,
            overview: movie.overview,
            poster_path: movie.posterPath,
            vote_count: movie.voteCount,
            release_date: movie.firstAirDate ?? movie.releaseDate,
            vote_average: movie.voteAverage, first_air_date: movie.firstAirDate)
        vc.viewModel.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
