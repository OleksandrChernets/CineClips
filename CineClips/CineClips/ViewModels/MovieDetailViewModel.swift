//
//  MovieDetailViewModel.swift
//  CineClips
//
//  Created by Alexandr Chernets on 22.02.2023.
//

import UIKit

final class MovieDetailViewModel {
    
    var movie: Movie? 
    var trailerId: String?
    var movieFromRealm: MovieRealm?
    
    // MARK: - Public Methods
    func saveMovieToRealm(movie: Movie?) {
        guard let movie = movie else { return }
        MovieDataManager.shared.saveMovie(movie: movie)
    }
    
    func deleteMovie(movie: Movie?) {
        guard let movie = movie else { return }
        let movieRealm = MovieDataManager.shared.getMovieToRealm(movie: movie)
        MovieDataManager.shared.deleteMovie(movie: movieRealm)
    }
    
    // MARK: - Network Requests
    func getMovieTrailer(completion: @escaping () -> ()) {
        APICaller.shared.getMovieTrailer(with: String(movie?.id ?? 0)) { trailer in
            self.trailerId = trailer.key
            completion()
        }
    }
    
    func getTVTrailer(completion: @escaping () -> ()) {
        APICaller.shared.getTVTrailer(with: String(movie?.id ?? 0)) { trailer in
            self.trailerId = trailer.key
            completion()
        }
    }
    
    // MARK: - UI Configuration
    func configureUI(title: UILabel, description: UILabel, dateLabel: UILabel, voteCount: UILabel) {
        title.text = movie?.original_title ?? movie?.original_name
        description.text = movie?.overview
        dateLabel.text = movie?.release_date ?? movie?.first_air_date
        voteCount.text = "\(movie?.vote_average ?? 0) (\(movie?.vote_count ?? 0) reviews)"
    }
}
