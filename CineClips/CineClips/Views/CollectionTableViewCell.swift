//
//  CollectionTableViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 07.02.2023.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func tableViewCellDelegate(movie: Movie)
}

class CollectionTableViewCell: UITableViewCell {
    
    private var titles: [Movie] = [Movie]()
    weak var delegate: CollectionTableViewCellDelegate?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    public func configure(with titles: [Movie]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path ?? titles[indexPath.row].backdrop_path,
              let rate = titles[indexPath.row].vote_average
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: model, with: rate)
        return cell
    }
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        CGSize(width: 140, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itm = titles[indexPath.row]
        delegate?.tableViewCellDelegate(movie: itm)
    } 
    
}

// asdasd
