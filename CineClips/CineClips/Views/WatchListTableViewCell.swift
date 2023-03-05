//
//  WatchListCollectionViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 03.03.2023.
//

import UIKit
import SDWebImage

protocol WatchListTableViewCellDelegate: AnyObject {
    func tableViewCellDelegate(movie: MovieRealm)
}

class WatchListTableViewCell: UITableViewCell {
    
    // MARK: - Cell Identifier
    static let identifier = "WatchListTableViewCell"
    
    // MARK: - Properties
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieType: UILabel!
    weak var delegate: WatchListTableViewCellDelegate?
    
    
    // MARK: - Public methods
    
    func configureWith(movie: MovieRealm) {
        
        // Load movie image
        let model = movie.posterPath ?? movie.backdropPath
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model ?? "")") else {
            return
        }
        //  Set up other UI elements
        movieLabel.text = movie.originalTitle
        overview.text = movie.overview
        ratingLabel.text = "\(movie.voteAverage ?? 0)"
        movieImage.sd_setImage(with: url, completed: nil)
    }
}
