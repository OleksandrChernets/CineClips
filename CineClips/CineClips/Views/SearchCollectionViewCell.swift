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

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    weak var delegate: SearchCollectionViewCellDelegate?
    
    
    public func configure(with model: MovieViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {
            return
        }
        posterImage.sd_setImage(with: url, completed: nil)
        
    }
}
