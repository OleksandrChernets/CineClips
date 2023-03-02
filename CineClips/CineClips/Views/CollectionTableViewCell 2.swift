//
//  CollectionTableViewCell.swift
//  CineClips
//
//  Created by Alexandr Chernets on 06.02.2023.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
        }
    }
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
}


extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = UICollectionViewCell()
        cell.backgroundColor = .green
        return cell
        
    }
    
    
}
