//
//  GenreCollectionViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 06.02.2023.
//

import UIKit
import SDWebImage

class GenreCollectionViewCell: UICollectionViewCell {
  
    private var titles: [Movie] = [Movie]()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var averageLabel: UILabel!
    
    // MARK: ConfigureUI
    public func configure(with model: String, with rate: Double) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
            return
        }
        posterImage.sd_setImage(with: url, completed: nil)
        averageLabel.text = String(rate)
    }
}
