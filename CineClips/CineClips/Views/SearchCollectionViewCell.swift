//
//  SearchCollectionViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 18.02.2023.
//

import UIKit

protocol SearchCollectionViewCellDelegate: AnyObject {
    func collectionViewCellDelegate(movie: Movie)
}

final class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Cell Identifier
    static let identifier = "SearchCollectionViewCell"
    
    //MARK: @IBOutlets
    @IBOutlet weak var posterImage: UIImageView!
    
    //MARK: Properties
    weak var delegate: SearchCollectionViewCellDelegate?
    
    // MARK: Publick Methods
    public func configure(with model: MoviePosterURL){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {
            return
        }
        posterImage.sd_setImage(with: url, completed: nil)
    }
}
