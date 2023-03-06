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
    var viewModel: WatchListViewModel = WatchListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "WATCH LIST"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovie()
        self.tableView.reloadData()
        tableView.setContentOffset(.zero, animated: true)
    }
}



// MARK: UITableViewDelegate & UITableViewDataSource

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.isEmpty ? 0 : viewModel.movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as? WatchListTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configureWith(movie: viewModel.movies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let movieToDelete = self.viewModel.movies[indexPath.row]
            self.viewModel.deleteMovie(movie: movieToDelete)
            self.viewModel.movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        deleteAction.image = UIImage(named: "deleteMovieImage")
        let tableViewColor = tableView.backgroundColor ?? .black
        deleteAction.backgroundColor = tableViewColor
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.movies[indexPath.row]
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
