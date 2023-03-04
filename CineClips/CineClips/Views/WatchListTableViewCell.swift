//
//  WatchListCollectionViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//

import UIKit
import SDWebImage

class WatchListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieType: UILabel!
    
    
    
    
//    public func configure(with model: String, with rate: Double, with language: String, with movieType: String, with movieLabel: String) {
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
//            return
//        }
//        movieImage.sd_setImage(with: url, completed: nil)
//        self.ratingLabel.text = String(rate)
//        self.languageLabel.text = language
//        self.movieLabel.text = movieLabel
//        self.movieType.text = movieType
//    }
    func configureWith(movie: MovieRealm) {
        let model = movie.posterPath ?? movie.backdropPath
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model ?? "")") else {
            return
        }
        
        movieLabel.text = movie.originalTitle
        overview.text = movie.overview
        ratingLabel.text = "\(movie.voteAverage ?? 0)"
        movieImage.sd_setImage(with: url, completed: nil)
    }
}
